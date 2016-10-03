class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :plan
  has_one :plan_user, class_name: 'Plan', foreign_key: 'subscription_id'

  attr_accessor :paypal_payment_token

  def active?
    canceled_on.nil?
  end

  def cancel_with_paypal!
    update(canceled_on: Date.today)
    paypal.cancel_recurring_payment
  end

  def paypal
    PaypalPayment.new(self)
  end

  def save_with_paypal
    response = paypal.finish_payment
    self.paypal_recurring_profile_token = response.profile_id
    save!
  end
end
