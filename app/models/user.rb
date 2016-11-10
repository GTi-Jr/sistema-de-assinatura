class User < ActiveRecord::Base
  @@max_addresses_number = 3

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable

  usar_como_cpf :cpf

  has_many :addresses
  has_many :subscriptions, -> { where(canceled_on: nil) }
  has_many :canceled_subscriptions, -> { where.not(canceled_on: nil) }, class_name: 'Subscription'
  has_many :plans, through: :subscriptions

  accepts_nested_attributes_for :addresses

  validates :addresses, length: { maximum: @@max_addresses_number }

  after_save :subscribe_user_to_mailing_list

  def owns_subscription?(subscription)
    subscriptions.include?(subscription)
  end

  def has_any_subscription?
    !subscriptions.empty?
  end

  def addresses_full?
    addresses.count >= @@max_addresses_number
  end

  def main_address
    addresses.find_by main: true
  end

  def has_any_address?
    addresses.any?
  end

  def babies_full?
    babies.count >= @@max_babies_number
  end

  def cancel_subscription(subscription)
    if subscriptions.include?(subscription)
      subscription.cancel_with_paypal!
    else
      false
    end
  end

  def subscribe_to_plan(plan)
    if plan.nil?
      return update(plan: plan)
    end
    false
  end

  def first_name
    name ? name.split(' ').first : ''
  end

  def last_name
    name ? name.split(' ').last : ''
  end

  def any_subscriptions?
    !subscriptions.empty?
  end

   def subscribed?
    !!subscription_id
  end

  def customer
    unless customer_id
      customer = Iugu::Customer.create({ email: email, name: name }) rescue false
      update_attribute :customer_id, customer.id
      return customer
    end

    Iugu::Customer.fetch(customer_id) rescue nil
  end

  def subscription
    Iugu::Subscription.fetch(subscription_id) if subscribed?
  end

  def payment_methods
    Iugu::PaymentMethod.search({customer_id: customer_id}).results rescue []
  end

  def invoices
    Iugu::Invoice.search( customer_id: customer_id ).results rescue []
  end

  protected

    def subscribe_user_to_mailing_list
      SubscribeUserToMailingListJob.perform_later(id)
    end
end
