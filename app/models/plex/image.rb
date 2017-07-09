module Plex
  class Video < ActiveRecord::Base
    include VideoUploader::Attachment.new(:avatar)


  end
end