module  Plex
  class Video < ActiveRecord::Base

    include VideoUploader::Attachment.new(:video)

    def upload(params, user, url)
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
      obj['url'] = "#{url}/streams/#{name}"
      obj['thumbnail_url'] = "#{url}/thumbnails/#{name}.png"
      puts obj.nil?
      if obj.nil?
        render json: { message: 'Upload has failed' }
      else
        @video = user.videos.create(obj)
        @video.save
        convert(file, name)
      end
    end

    def convert(file, name)
      path_to_streams = Rails.root / 'public' / 'streams'
      preset480p = [
          '-c:v libx264',
          '-c:a aac',
          '-s hd480',
          '-aspect 16:9',
          '-hls_time 10',
          '-hls_list_size 0',
          '-f hls'
      ]
      preset720p = [
          '-c:v libx264',
          '-c:a aac',
          '-s hd720',
          '-aspect 16:9',
          '-hls_time 10',
          '-hls_list_size 0',
          '-f hls'
      ]
      name480 = '' + name + '480'
      name720 = '' + name + '720'
      VideoProccesingWorker.perform_async(file, path_to_streams, name480, preset480p, @uploaded_file.id, false)
      VideoProccesingWorker.perform_async(file, path_to_streams, name720, preset720p, @uploaded_file.id, true)
    end

    def delete(id, flag)
      storage_path = Rails.root / 'public' / 'uploads' / 'cache'
      if flag == true
        `rm #{storage_path}/#{id}`
      end
    end
  end
end