class SubscriptionsController < ApplicationController
  before_action :set_subscription, only: [:confirm_cancellation]

  def confirm_cancellation
    @plan = @subscription.plan
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_subscription
    @subscription = Subscription.find(params[:id])
  end
end
