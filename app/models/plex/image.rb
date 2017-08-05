module Plex
  class Video < ActiveRecord::Base
    include ImageUploader::Attachment.new(:avatar)
    include ImageUploader::Attachment.new(:cover)

    def upload_avatar(params, user_id)
      if params == 'avatar_data' 
          
      end
    end

  end
end