class UsersController < ApplicationController
  before_action :check_user_completed

  def profile
  end

  private
    def user_params
      params.require(:user).permit(:email,:name,:sex,:birthdate,:cpf,:rg,:password, :password_confirmation,baby_attributes: %i(id name born user_id))
    end
end
