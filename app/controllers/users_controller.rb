class UsersController < ApplicationController
  def new
    @user = User.new(user_params)
  end

  def create
    @user = User.new(user_params)
    @user.complete = true

    if @user.save
      sign_in @user
      redirect_to user_profile_path, notice: 'A Cegonha está a todo vapor, preparando as caixinhas mais especiais para você! Assim que elas estiverem prontas, entraremos em contato para confirmar sua assinatura! Obrigada!'
    else
      render :new
    end
  end

  protected
  def user_params
    params.require(:user).permit(:email, :name, :sex, :birthdate, :phone, :cpf, :rg, :password, :password_confirmation, :plan_intention)
  end
end
