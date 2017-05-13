module  Plex
  class VideosController < ApplicationController

    def new
      @video = Video.new
    end

    def create
      uploader = VideoUploader.new(:store)
      uploaded_file = uploader.upload(params[:video])
      obj = {}
      obj['video_data'] = uploaded_file.to_json
      obj['user_id'] = @current_user.id
      video = Video.new(obj)
      video.save
    end

  end
end