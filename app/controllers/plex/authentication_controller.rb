module Plex
  class AuthenticationController < ApplicationController
    skip_before_action :authenticate_request

    def authenticate
      command = AuthenticateUser.call(params[:user][:username], params[:user][:password])

      if command.success?
        render json: { token: command.result, username: params[:user][:username] }
      else
        render json: { error: command.errors }
      end
    end

    def user_params
      params.require(:user).permit(:username, :password)
    end

    private :user_params
  end
end