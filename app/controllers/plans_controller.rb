class PlansController < ApplicationController
  before_action :authenticate_user!, only: [:subscribe, :unsubscribe]
  before_action :set_plan, only: [:show, :subscribe]

  def show
  end

  def index
    @plans= Plan.all
  end

  def subscribe
    if !current_user.has_any_address?
      redirect_to :back, alert: 'Adicione um endereço'
    elsif current_user.subscribe_to_plan(@plan)
      redirect_to user_profile_path, notice: 'Inscrito com sucesso'
    else
      redirect_to :back, notice: 'Erro na inscrição'
    end
  end

  def unsubscribe
    if current_user.cancel_plan
      redirect_to user_profile_path, notice: 'Assinatura Cancelada'
    else
      redirect_to user_profile_path, notice: 'Houve um problema no cancelamento'
    end
  end

  def intention_to_plan
    plan = Plan.find(params[:plan_id])
    if current_user.update plan_intention: plan.id
      redirect_to :back, notice: 'Intenção de plano para #{plan.name}'
    else
      redirect_to :back, alert: 'Não foi possível registrar a intenção de plano'
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
