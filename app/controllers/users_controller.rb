class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_user_completed

  def profile
    @babies = current_user.babies # Carregar os bebês numa variável para nao acessar BD na view
    current_user.babies.build # Para caso o usuário deseje adicionar um novo bebê

    @addresses = current_user.addresses
    current_user.addresses.build
  end

  private
    def user_params
      params.require(:user).permit(:email,:name,:sex,:birthdate,:cpf,:rg,:password, :password_confirmation,baby_attributes: %i(id name born user_id))
    end
end
