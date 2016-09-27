class User < ActiveRecord::Base
  @@max_addresses_number = 3
  @@max_babies_number = 10

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  usar_como_cpf :cpf

  has_many :babies
  has_many :addresses
  has_one :subscription, -> { where canceled_on: nil }, class_name: 'Subscription'
  has_many :subscriptions
  has_one :plan, through: :subscription

  accepts_nested_attributes_for :babies
  accepts_nested_attributes_for :addresses
  accepts_nested_attributes_for :plan
  accepts_nested_attributes_for :subscription

  validates :addresses, length: { maximum: @@max_addresses_number }
  validates :babies, length: { maximum: @@max_babies_number }

  def addresses_full?
    addresses.count >= @@max_addresses_number
  end

  def main_address
    addresses.find_by main: true
  end

  def babies_full?
    babies.count >= @@max_babies_number
  end

  def cancel_plan
    subscription.cancel!
  end

  def subscribe_to_plan(plan)
    if self.plan.nil?
      return update(plan: plan)
    end
    false
  end
end
