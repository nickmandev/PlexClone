module Plex
  class AuthenticateUser
    prepend SimpleCommand

    def initialize(username, password)
      @username = username
      @password = password
    end

    def call
      JsonWebToken.encode(user_id: user.id) if user
    end

    attr_accessor :username, :password

    def user
      user = User.find_by_name(username)
      if user && user.authenticate(password)
        return user
      end

      errors.add(:user_authenticate, 'Invalid credentials')
      nil
    end

    private :user
  end
end

