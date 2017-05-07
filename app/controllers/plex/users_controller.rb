module Plex
  class UsersController < ApplicationController
    def new
      @user = User.new
    end

    def create
      user = User.new
      obj = {}
      request.body.each do |req|
        hash = JSON.parse(req, :symbolize_names => true)
        obj = hash[:user]
        obj[:password] = user.hash_password(hash[:password])
      end
      record = User.new(obj)
      if user.test_email(obj[:email])
        record.save ? (render json: {message: 'Account created'}) : (render json: {message: 'Account creation failed'})
      else
        render json: {message: 'Email is invalid'}
      end
    end

    def user_params
      params.require(:user).permit(:name, :email, :password)
    end

    private :user_params
  end
end

