require 'bcrypt'
module Plex
  class User < ActiveRecord::Base

    def hash_password(password)
      hashed_password = BCrypt::Password.create(password)
    end

    def test_email(email)
      regex = Regexp.new(/\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i)
      regex.match?(email)
    end

    def authenticate(params)
      user = User.where(name: params[:emailUsername]) || User.where(email: params[:emailUsername])
      user.each do |usr|
        unhashed_password = BCrypt::Password.new(usr.password) == params[:password]
        puts unhashed_password
      end
    end
  end
end

