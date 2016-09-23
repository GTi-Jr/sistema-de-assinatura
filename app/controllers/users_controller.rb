class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_user_completed

  def profile
    build_user_address
    build_user_baby
  end

  def update
    if current_user.update(user_params)
      redirect_to :back, notice: 'Informações atualizadas'
    else
      redirect_to :back, alert: 'Não foi possível atualizar seus dados'
    end
  end

  def add_address
    @address = current_user.addresses.build(address_params)

    if @address.save
      redirect_to :back, notice: 'Endereço cadastrado'
    else
      profile
      render :profile
    end
  end

  def update_addresses
    if current_user.update(user_addresses_params)
      redirect_to :back, notice: 'Endereços atualizados'
    else
      render :profile
    end
  end

  private
    def build_user_address
      @address = Address.new
    end

    def build_user_baby
      @baby = Baby.new
    end

    def user_params
      params.require(:user).permit(:email, :name, :sex, :birthdate, :cpf, :rg, :password, :password_confirmation)
    end

    def user_addresses_params
      params.require(:user).permit(address_attributes: %i(street state city zipcode number))
    end

    def address_params
      params.require(:address).permit(:street, :state, :city, :zipcode, :number)
    end

    def user_babies_params
      params.require(:user).permit(baby_attributes: %i(id name born birthdate weeks user_id))
    end

    def baby_params
      params.require(:baby).permit(:name, :born, :birthdate, :weeks)
    end
end
