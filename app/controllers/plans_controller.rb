class PlansController < ApplicationController
  before_action :authenticate_user!, only: [:subscribe, :unsubscribe]
  before_action :set_subscription, only: [:unsubscribe,:iugu_unsubscribe]
  before_action :set_plan, only: [:show, :subscribe,:iugu_subscribe]

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
    if current_user.cancel_subscription(@subscription)
      redirect_to user_profile_path, notice: 'Assinatura Cancelada'
    else
      redirect_to user_profile_path, notice: 'Houve um problema no cancelamento'
    end
  end

  def iugu_subscribe
    customer = current_user.customer
    iugu_plan = Iugu::Plan.fetch(@plan.iugu_id)

    subscription = Iugu::Subscription.create({
      plan_identifier: iugu_plan.identifier,
      customer_id: current_user.customer_id,
    })

    user= current_user
    user.subscriptions.build(plan: @plan)
    user.subscriptions.last.iugu_id = subscription.id
    if user.save
      redirect_to subscription.recent_invoices[0]['secure_url'], notice: "Plano #{subscription.plan_name} Assinado"
    else
      redirect_to root_path, notice: 'Erro na Assinatura'
    end
  end

  #Funcionou no terminal, só precisando ajeitar os parametros agora, e tentar substituir items por plan
  def create_invoice
        Iugu::Invoice.create({
        customer_id: user.customer_id,
        due_date: "08/12/2016",
        subscription_id: subscription.id,
        items: [{
            description: 'Item 1',
            quantity: "1",
            price_cents: subscription.price_cents
        }]

    })
  end

  def iugu_unsubscribe
      subscription = Iugu::Subscription.fetch(@subscription.iugu_id)
      subscription.delete
      user = current_user
      user.subscriptions.where(id: @subscription.id).first.destroy
      redirect_to root_path, 'Assinatura Cancelada'
  end

  def intention_to_plan
    plan = Plan.find(params[:plan_id])
    if current_user.present?
      if current_user.update plan_intention: plan.id
        redirect_to :back, notice: "Intenção de plano para #{plan.name} registrada"
      else
        redirect_to :back, alert: 'Não foi possível registrar a intenção de plano'
      end
    end
    @user = User.new(plan_intention: plan.id)
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_plan
      @plan = Plan.find(params[:id])
    end

    def set_subscription
      @subscription = Subscription.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def plan_params
      params.require(:plan).permit(:name,:duration,:description,:subscription_id)
    end
end
