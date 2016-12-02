class ProfileController < ApplicationController
  before_action :authenticate_user!
  before_action :check_user_completed
  before_action :load_subscription, only: [:update_subscription_babies]

  def profile
    @address ||= Address.new

    @subscriptions = current_user.subscriptions

    @user_addresses = current_user.addresses.order('main DESC')
    @user_main_address = current_user.main_address
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

  def update_subscription_babies
    @subscription = Subscription.find(params[:subscription_id])

    if current_user.owns_subscription?(@subscription)
      if @subscription.update(subscriptions_babies_params)
        redirect_to :back, notice: 'Bebês atualizados'
      else
        profile
        render :profile
      end
    else
      redirect_to :back, alert: 'Não foi possível fazer a alteração. Tente novamente'
    end
  end

  private
    def load_subscription
      @subscription = Subscription.find(params[:subscription_id])
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
      params.require(:user).permit(babies_attributes: %i(id name born birthdate weeks))
    end

    def baby_params
      params.require(:baby).permit(:name, :born, :birthdate, :weeks)
    end

    def subscriptions_babies_params
      params.require(:subscription).permit(baby_attributes: %i(name born birthdate weeks))
    end
end
