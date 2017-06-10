module Plex
  class CommentsResponseController < ApplicationController
    def new
      response = CommentsResponse.new
    end

    def create
      comment = Comment.find_by_id(comments_response_params['comment_id'])
      response = comment.comments_response.new(comments_response_params)
      response['user_info'] = UsersHelpers.current_user.name.to_json
      response.save ? (render json: { response: response }) : (render json: { error: 'The comment was not posted.' })
    end

    def comments_response_params
      params.require(:comments_response).permit(:body, :comment_id)
    end

    private :comments_response_params
  end
end