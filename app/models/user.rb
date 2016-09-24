class User < ActiveRecord::Base
  @@max_addresses_number = 3

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  has_many :babies
  has_many :addresses
  has_one :subscription
  has_one :plan, through: :subscription, :autosave => false
  #has_many :plans, through: :subscriptions

  accepts_nested_attributes_for :babies
  accepts_nested_attributes_for :addresses
  accepts_nested_attributes_for :plan
  accepts_nested_attributes_for :subscription

  usar_como_cpf :cpf

  validates :addresses, length: { maximum: @@max_addresses_number }

  def addresses_full?
    addresses.count >= @@max_addresses_number
  end

  def main_address
    addresses.find_by main: true
  end
end
