class Plans::PaymentsController < PlansController
  before_action :set_plan, except: [:confirm_payment]

  def confirm_checkout
  end

  private

  def set_plan
    @plan = Plan.find_by(identifier: params[:plan_identifier])
  end
end
