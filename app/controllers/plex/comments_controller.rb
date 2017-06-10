module Plex
  class CommentsController < ApplicationController

    def new
      @comment = Comment.new
    end

    def create
      video = Video.find_by_id(comments_params['video_id'])
      comment = video.comments.new(comments_params)
      comment['user_info'] = UsersHelpers.current_user.name.to_json
      comment.save ? (render json: { comment: comment }) : (render json: { error: 'The comment was not posted.' })
    end

    def comments_params
      params.require(:comment).permit(:body, :video_id)
    end

    private :comments_params
  end
end