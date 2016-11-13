class Iugu::WebhooksController < ApplicationController
  protect_from_forgery with: :null_session

  def webhook
    case params[:event]
    when 'subscription.created'
    when 'subscription.activated' then subscription_activated
    when 'subscription.suspended'
    when 'subscription.expired'
    end

    render nothing: true
  end

  private

  def subscription_activated
    iugu_subscription = Iugu::Subscription.fetch(params[:data][:subscription_id])
    @user = User.find_by(customer_id: iugu_subscription.customer_id)
    @subscription = @user.subscriptions.create(plan: @plan, iugu_id: iugu_subscription.id)
  end
end
