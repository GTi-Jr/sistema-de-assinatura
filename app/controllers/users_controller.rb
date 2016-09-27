class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_user_completed

  def profile
    @address ||= Address.new
    @baby ||= Baby.new

    @user_addresses = current_user.addresses.order('main DESC')
    @user_main_address = current_user.main_address

    @user_babies = current_user.babies.order(:name)

    @user_plan = current_user.plan
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
      profile
      render :profile
    end
  end

  def update_main_address
    address = Address.find(params[:address_id])

    if address.user.id == current_user.id
      address.become_main
      redirect_to :back, notice: 'Endereço principal atualizado'
    else
      redirect_to :back, alert: 'Não foi possível alterar seu endereço principal'
    end
  end

  def update_babies
    if current_user.update(user_babies_params)
      redirect_to :back, notice: 'Bebês atualizados'
    else
      profile
      render :profile
    end
  end

  def add_baby
    @baby = current_user.babies.build(baby_params)

    if @baby.save
      redirect_to :back, notice: 'Bebê adicionado'
    else
      profile
      render :profile
    end
  end

  private
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
      params.require(:user).permit(babies_attributes: %i(id name born birthdate weeks))
    end

    def baby_params
      params.require(:baby).permit(:name, :born, :birthdate, :weeks)
    end
end
