class UsersController < ApplicationController

  def new
    @user= User.new
    @user.babies.build
  end

  private
    def user_params
      params.require(:user).permit(:email,:name,:sex,:birthdate,:cpf,:rg,:street,:number,:password, :password_confirmation,baby_attributes: %i(id name born user_id))
    end
end
