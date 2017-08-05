module Plex
  class UsersController < ApplicationController
    skip_before_action :authenticate_request, only: [:new, :create]
    
    def index
      user = User.find_by_id(UsersHelpers.current_user.id)
      render json: { user: user }
    end

    def new
      @user = User.new
    end

    def create
      user = User.new
      url = "#{request.protocol + request.host_with_port}"
      obj = {}
      request.body.each do |req|
        hash = JSON.parse(req, :symbolize_names => true)
        obj = hash[:user]
      end
      record = User.new(obj)
      if user.test_email(obj[:email])
        if User.find_by(name: obj[:name])
          render json: { message: 'Account with that Username exists' }
        else
          record.save ? (render json: { message: 'Account created' }) : (render json: {message: 'Account creation failed'})
        end
      else
        render json: { message: 'Email is invalid' }
      end
    end

    def update
      user_model = User.new
      if params['image_data'] || params['cover_data']
        user_model.upload_image(params, UsersHelpers.current_user)
      else
        UsersHelpers.current_user.update(params)
      end
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, :image_data, :cover_data)
    end

    private :user_params
  end
end

