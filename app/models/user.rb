require 'bcrypt'

module PlexBackend
  class User < ActiveRecord::Base

    has_secure_password

    @bcrypt = BCrypt.new

    def hash_password(password)
      hashed_password = @bcrypt::Password.create(password)
    end
  end
end
