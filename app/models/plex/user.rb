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
  end
end
