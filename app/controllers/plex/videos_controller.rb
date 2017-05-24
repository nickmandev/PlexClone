module Plex
  class VideosController < ApplicationController

    def new
      @video = Video.new
    end

    def index
      videos = @current_user.videos
      render json: { data: videos }
    end

    def create
      url = "#{request.protocol + request.host_with_port}"
      video = Video.new
      video.upload(params, @current_user, url)
    end

    def stream

    end
  end
end