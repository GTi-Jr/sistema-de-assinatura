class PlansController < ApplicationController

  before_action :set_plan, only: [:show]

  def show

  end

  def index
    @plans= Plan.all
  end

  def subscribe
    @user= User.find(params[:user_id])
    @plan= Plan.find(params[:id])
    @user.build_subscription
    @user.build_subscription.plan = @plan

    if @user.save
      redirect_to :back, notice: 'Inscrito com sucesso'
    else
      redirect_to :back, notice: 'Erro na Inscrição'
    end

  end


  def unsubscribe
    if current_user.cancel_plan
      redirect_to '/perfil', notice: 'Assinatura Cancelada'
    else
      redirect_to '/perfil', notice: 'Houve um problema no cancelamento'
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_plan
      @plan = Plan.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def plan_params
      params.require(:plan).permit(:name,:duration,:description,:subscription_id)
    end
end
