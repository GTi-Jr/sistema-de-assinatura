class AddressesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_address, only: [:update, :destroy]

  def create
    @address = current_user.addresses.build(address_params)

    if @address.save
      redirect_to user_profile_path, notice: 'Endereço cadastrado'
    else
      redirect_to user_profile_path, alert: 'Não foi possível cadastrar seu endereço'
    end
  end

  def update
    if current_user == @address.user && @address.update(address_params)
      redirect_to user_profile_path, notice: 'Endereço atualizado'
    else
      redirect_to user_profile_path, alert: 'Não foi possível atualizar seu endereço'
    end
  end
  
  def destroy
    if current_user == @address.user && @address.destroy
      redirect_to user_profile_path, notice: 'Endereço excluído'
    else
      redirect_to user_profile_path, alert: 'Não foi possível excluir o endereço'
    end
  end
  
  private

  def set_address
    @address = Address.find(params[:id])
  end

  def address_params
    params.require(:address).permit(:street, :number, :zipcode, :city, :state)
  end
end
