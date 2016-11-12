class Iugu::CheckoutsController < ApplicationController
  skip_before_filter  :verify_authenticity_token

  before_action :authenticate_user!
  before_action :set_plan

  def subscribe
    iugu_plan = Iugu::Plan.fetch(@plan.iugu_plan_id)

    iugu_subscription = Iugu::Subscription.create({
      plan_identifier: @plan.iugu_plan_id,
      customer_id:     current_user.customer_id
    })

    subscription = current_user.subscriptions.build(plan: @plan)
    subscription.iugu_id = iugu_subscription.id

    if subscription.save
      redirect_to subscription.recent_invoices.first['secure_url']
    else
      redirect_to user_profile_path, alert: 'Não foi possível proceder para assinatura'
    end
  end

  private

  def set_plan
    @plan = Plan.find(params[:plan_id])
  end
end
