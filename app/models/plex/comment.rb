module Plex
  class Comment < ActiveRecord::Base
    belongs_to :video
    has_many :comments_response
  end
end
