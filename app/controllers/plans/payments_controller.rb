class Plans::PaymentsController < PlansController
  def checkout
    @plan = Plan.find(params[:plan_id])
  end
end
