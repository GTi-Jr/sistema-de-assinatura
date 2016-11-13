class Iugu::WebhooksController < ApplicationController
  protect_from_forgery with: :null_session

  def webhook
    case params[:event]
    when 'subscription.created'   then subscription_created
    when 'subscription.activated' then subscription_activated
    when 'subscription.suspended' then subscription_suspended
    when 'subscription.expired'   then subscription_expired
    when 'invoice.created'        then invoice_created
    when 'invoice.status_changed' then invoice_status_changed
    end

    render nothing: true
  end

  private

  def subscription_created
    iugu_subscription = Iugu::Subscription.fetch(params[:data][:subscription_id])
    last_invoice = iugu_subscription.recent_invoices[0]

    @user = User.find_by(customer_id: iugu_subscription.customer_id)
    @subscription = @user.subscriptions.create(
      plan: @plan,
      iugu_id: iugu_subscription.id,
      iugu_payment_status:  last_invoice['status']
    )
  end

  def subscription_activated
  end

  def subscription_suspended
  end

  def subscription_expired
  end

  def invoice_created
  end

  def invoice_status_changed
  end
end

