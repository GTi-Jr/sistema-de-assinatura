class PaypalPayment
  def initialize(subscription)
    @subscription = subscription
  end

  def checkout_details
    process :checkout_details
  end

  def checkout_url(options)
    process(:checkout, options).checkout_url
  end

  def finish_payment
    process :request_payment
    #TODO Mudar o start_at para a todo dia 25
    process :create_recurring_profile, period: :monthly, frequency: 1, start_at: Time.zone.now
  end

  def cancel_recurring_payment
    ppr = PayPal::Recurring.new(profile_id: @subscription.paypal_recurring_profile_token)
    ppr.cancel
  end

  private

  def process(action, options = {})
    options = options.reverse_merge(
      token: @subscription.paypal_payment_token,
      payer_id: @subscription.paypal_customer_token,
      description: "#{@subscription.plan.name}: #{@subscription.plan.description}",
      amount: @subscription.plan.price.to_s,
      currency: 'BRL'
    )

    response = PayPal::Recurring.new(options).send(action)
    raise response.errors.inspect if response.errors.present?
    response
  end
end
