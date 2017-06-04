module UsersHelpers
  thread_mattr_accessor :current_user
end

module Plex
  class ApplicationController < ActionController::API
    before_action :authenticate_request
    include UsersHelpers

    def authenticate_request
      current_user = AuthorizeApiRequest.call(request.headers).result
      UsersHelpers.current_user = current_user
      render json: { error: 'Not Authorized' }, status: 401 unless current_user
    end

    private :authenticate_request
  end
end

