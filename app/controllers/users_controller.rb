class UsersController < ApplicationController
  def new
    @user = User.new(user_params)
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to user_profile_path, notice: 'Em breve entraremos em contato!'
    else
      render :new
    end
  end

  protected
  def user_params
    params.require(:user).permit(:email, :name, :sex, :birthdate, :phone, :cpf, :rg, :password, :password_confirmation, :plan_intention)
  end
end
