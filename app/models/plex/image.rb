module Plex
  class Video < ActiveRecord::Base
    include ImageUploader::Attachment.new(:avatar)

    def upload_avatar(params, user_id)

    end
    
  end
end