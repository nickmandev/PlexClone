require 'streamio-ffmpeg'
module Plex
  class VideoProccesingWorker

    include Sidekiq::Worker

    sidekiq_options :retry => false

    def perform(file, path, presets, id, flag)
      movie = FFMPEG::Movie.new(file)
      options = {
          video_codec: 'libx264',
          audio_codec: 'aac',
          video_bitrate: presets['bitrate'],
          resolution: presets['resolution'],
          custom: %w(-hls_time 10  -hls_list_size 0 -f hls)
      }
      `mkdir #{path}/#{presets['name']}`
      filename = "#{path}/#{presets['name']}"
      movie.transcode("#{filename}/index.m3u8", options) { |progress| puts progress }
      video = Video.new
      video.delete(id, flag)
    end
  end
end
