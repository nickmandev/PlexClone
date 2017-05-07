module Plex
  class SessionsController < ApplicationController
    def create
      user = User.new
      params = ''
      request.body.each do |req|
        hash = JSON.parse(req, :symbolize_names => true)
        params = hash[:user]
      end
      puts params
      user.authenticate(params)
    end


    def session_params
      params.require(:user).permit(:emailUsername, :password)
    end
  end
end

