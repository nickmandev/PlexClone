module Plex
  class VideosController < ApplicationController

    def new
      @video = Video.new
    end

    def index
      videos = Video.all.order('videos.created_at DESC')
      render json: { data: videos }
    end

    def create
      url = "#{request.protocol + request.host_with_port}"
      video = Video.new
      video.upload(params, UsersHelpers.current_user, url)
    end

    def show
      video = Video.find_by_id(params[:id])
      render json: { video: video }
      if video.view_count.nil?
        video.view_count = 0
      end
      video.view_count += 1
      video.save
    end

    def user_by_name
      user = User.find_by(name: params[:name])
      videos = user.videos
      render json: { videos: videos, user: user  }
    end
  end
end