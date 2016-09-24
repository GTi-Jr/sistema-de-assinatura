class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  has_many :babies
  has_many :addresses
  has_one :subscription
  has_one :plan, through: :subscription
  #has_many :plans, through: :subscriptions

  accepts_nested_attributes_for :babies
  accepts_nested_attributes_for :addresses

  usar_como_cpf :cpf
end
