class AddressesController < ApplicationController
  before_action :authenticate_user!
  
  def destroy
    address = Address.find(params[:id]).destroy

    if address.destroy
      redirect_to :back, notice: 'Endereço excluído'
    else
      redirect_to :back, alert: 'Não foi possível excluir o endereço'
    end
  end
end
