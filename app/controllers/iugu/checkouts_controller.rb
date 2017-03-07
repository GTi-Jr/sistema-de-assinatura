class Iugu::CheckoutsController < ApplicationController
  skip_before_filter  :verify_authenticity_token

  before_action :authenticate_user!
  #apague essa linha para liberar
  # before_action :block_actions
  before_action :set_plan, only: [:confirm_checkout, :checkout]
  before_action :set_subscription , only: [:suspend]

  def confirm_checkout
  end

  def checkout
    iugu_checkout = Iugu::Checkout.new(@plan, current_user, params[:token])

    if iugu_checkout.create_subscription.errors.nil?
      redirect_to user_profile_path, notice: "Seu plano foi assinado! Seu pagamento será processado até o próximo dia #{iugu_checkout.due_day}"
    else
      redirect_to user_profile_path, alert: 'Não foi possível assinar'
    end
  end

  def suspend
    iugu_subscription = Iugu::Subscription.fetch(@subscription.iugu_id)

    if iugu_subscription.suspend
      redirect_to user_profile_path, notice: 'Plano Suspenso'
    else
      redirect_to user_profile_path, notice: 'Tente novamente'
    end
  end

  private

  def set_plan
    @plan = ::Plan.find_by(identifier: params[:plan_identifier])
  end

  def set_subscription
    @subscription = Subscription.find(params[:subscription_id])
  end
end
