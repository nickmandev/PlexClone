require 'bcrypt'
module Plex
  class User < ActiveRecord::Base
    include ImageUploader::Attachment.new(:image)
    has_secure_password
    has_many :videos

    def test_email(email)
      regex = Regexp.new(/\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i)
      regex.match?(email)
    end

    def authenticated?(params)
      user = User.where(name: params[:emailUsername]) || User.where(email: params[:emailUsername])
      user.each do |usr|
        return usr.authenticate(params[:password].to_s)
      end
    end
  end
end

