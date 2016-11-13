class Iugu::CheckoutsController < ApplicationController
  skip_before_filter  :verify_authenticity_token

  before_action :authenticate_user!
  before_action :set_plan

  def checkout
    iugu_subscription = Iugu::Subscription.create({
      plan_identifier: @plan.identifier,
      customer_id:     current_user.customer_id
    })

    if iugu_subscription.errors.nil?
      redirect_to iugu_subscription.recent_invoices.first['secure_url']
    else
      redirect_to user_profile_path, alert: 'Não foi possível proceder para assinatura'
    end
  end

  private

  def set_plan
    @plan = ::Plan.find_by(identifier: params[:plan_identifier])
  end
end
