require 'streamio-ffmpeg'
module Plex
  class Video < ActiveRecord::Base
    belongs_to :user
    has_many :comments
    include VideoUploader::Attachment.new(:video)

    def upload(params, user, url)
      uploader = VideoUploader.new(:cache)
      @uploaded_file = uploader.upload(params[:video])
      path_to_uploads = Rails.root / 'public' / 'uploads' / 'cache'
      path_to_thumbnail = Rails.root / 'public' / 'thumbnails'
      name = @uploaded_file.id.split('.').first.to_s
      file = "#{path_to_uploads}/#{@uploaded_file.id}"
      movie = FFMPEG::Movie.new("#{path_to_uploads}/#{@uploaded_file.id}")
      movie.screenshot("#{path_to_thumbnail}/#{name}.png", seek_time: 30)
      obj = {}
      obj['video_data'] = {duration: movie.duration, filename: @uploaded_file.original_filename}.to_json
      obj['user_info'] = user.name.to_json
      obj['url'] = "#{url}/streams/#{name}"
      obj['thumbnail_url'] = "#{url}/thumbnails/#{name}.png"
      if obj.nil?
        render json: {message: 'Upload has failed'}
      end
      @video = user.videos.create(obj)
      @video.save
      convert(file, name)
    end

    def upload_old(params, user, url)
      uploader = VideoUploader.new(:cache)
      @uploaded_file = uploader.upload(params[:video])
      name = @uploaded_file.id.split('.').first.to_s
      path_to_uploads = Rails.root / 'public' / 'uploads' / 'cache'
      path_to_thumbnail = Rails.root / 'public' / 'thumbnails'
      id = @uploaded_file.id
      file = "#{path_to_uploads}/#{id}"
      `ffmpeg -i #{file} -ss 00:00:30.435 -vframes 1 #{path_to_thumbnail}/#{name}.png`
      obj = {}
      obj['video_data'] = @uploaded_file.to_json
      obj['user_info'] = user.name.to_json
      obj['url'] = "#{url}/streams/#{name}"
      obj['thumbnail_url'] = "#{url}/thumbnails/#{name}.png"
      obj['view_count'] = 0
      puts obj.nil?
      if obj.nil?
        render json: {message: 'Upload has failed'}
      else
        @video = user.videos.create(obj)
        @video.save
        convert(file, name)
      end
    end

    def convert(file, name)
      path_to_streams = Rails.root / 'public' / 'streams'
      preset480p = {
          bitrate: 500,
          resolution: '640x480',
          name: "#{name}480"
      }
      preset720p = {
          bitrate: 1000,
          resolution: '1280x720',
          name: "#{name}720"
      }
      VideoProccesingWorker.perform_async(file, path_to_streams, preset480p, @uploaded_file.id, false)
      VideoProccesingWorker.perform_async(file, path_to_streams, preset720p, @uploaded_file.id, true)
    end


    def delete(id, flag)
      storage_path = Rails.root / 'public' / 'uploads' / 'cache'
      if flag == true
        `rm #{storage_path}/#{id}`
      end
    end
  end
end