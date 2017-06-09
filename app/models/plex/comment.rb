module Plex
  class Comment < ActiveRecord::Base
    belongs_to :video
  end
end
