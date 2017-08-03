module Plex
  class Cover < ActiveRecord::Base
    include ImageUploader::Attachment.new(:cover)
  end
end