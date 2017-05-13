module  Plex
  class Video < ActiveRecord::Base
    include VideoUploader::Attachment.new(:video)
  end
end