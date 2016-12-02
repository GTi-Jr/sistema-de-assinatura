class SubscriptionsController < ApplicationController
  before_action :set_subscription

  def confirm_cancellation
    @plan = @subscription.plan
  end

  def choose_plan
    @plans = Plan.all.order(:price)
  end

  def confirm_change_plan
    @plan = Plan.find_by(identifier: params[:plan_identifier])
  end

  def change_plan
    plan = Plan.find_by(identifier: params[:plan_identifier])
    subscription.change_plan(plan)
    redirect_to user_profile_path, notice: 'Sua assinatura foi alterada!'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_subscription
    @subscription = current_user.subscriptions.where(id: params[:id]).first
    redirect_to :user_profile_path, alert: 'Erro ao escolher assinatura' if @subscription.nil?
  end
end
