require 'bcrypt'
module Plex
  class User < ActiveRecord::Base
    include ImageUploader::Attachment.new(:avatar)
    include ImageUploader::Attachment.new(:cover)

    has_secure_password
    has_many :videos

    def test_email(email)
      regex = Regexp.new(/\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i)
      regex.match?(email)
    end

    def upload_image(params, user)
      if params['cover_data']
        uploader = ImageUploader.new(:cover)
      else
        uploader = ImageUploader.new(:image)  
      end
      image = uploader.upload(params)
      user.update("#{params.keys().first}": image)
    end

    def authenticated?(params)
      user = User.where(name: params[:emailUsername]) || User.where(email: params[:emailUsername])
      user.each do |usr|
        return usr.authenticate(params[:password].to_s)
      end
    end
  end
end

