class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :plan
  has_one :plan_user, class_name: 'Plan', foreign_key: 'subscription_id'

  def active?
    !canceled_on.nil?
  end
end
