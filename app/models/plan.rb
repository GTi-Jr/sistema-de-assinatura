class Plan < ActiveRecord::Base

  belongs_to :subscription
  has_many :subscriptions
  has_many :users, through: :subscriptions

  def price_per_month
    price/duration.to_f
  end
end
