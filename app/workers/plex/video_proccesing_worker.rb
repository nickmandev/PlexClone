module Plex
  class VideoProccesingWorker

    include Sidekiq::Worker

    sidekiq_options :retry => false

    def perform(file, path, name, presets, id, flag)
      `mkdir #{path}/#{name}`
      `ffmpeg -i #{file} #{presets.join(' ')} #{path}/#{name}/index.m3u8`
      video = Video.new
      video.delete(id, flag)
    end
  end
end
