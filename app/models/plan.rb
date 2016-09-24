class Plan < ActiveRecord::Base

  belongs_to :subscription
  has_many :subscriptions
  has_many :users, through: :subscriptions

end
