class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    if params[:password] == params[:password_confirm]
        @user.hash_passsword(params[:password])
    end
    @user.create(params)
  end

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end


  private :user_params
end