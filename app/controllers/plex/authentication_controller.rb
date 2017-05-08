module Plex
  class AuthenticationController < ApplicationController
    skip_before_action :authenticate_request

    def authenticate
      command = AuthenticateUser.call(params[:user][:username], params[:user][:password])

      if command.success?
        render json: { auth_token: command.result }
      else
        render json: { error: command.errors }, status: :unauthorized
      end
    end

    def user_params
      params.require(:user).permit(:username, :password)
    end

    private :user_params
  end
end