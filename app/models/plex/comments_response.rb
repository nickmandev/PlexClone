module Plex
  class CommentsResponse < ActiveRecord::Base
    belongs_to :comment
  end
end