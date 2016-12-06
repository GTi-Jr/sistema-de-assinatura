class Iugu::Checkout
  attr_accessor :user, :plan, :iugu_customer,:token

  def initialize(plan, user, token)
    @plan  = plan
    @user  = user
    @token = token
    @iugu_customer = Iugu::Customer.fetch(user.customer_id)
  end

  def create_subscription
    create_payment_method
    subscription_options = options.merge(discount)
    Iugu::Subscription.create(subscription_options)
  end

  private

  def create_payment_method
    @iugu_customer.payment_methods.create({
      description: 'Cartão',
      token: @token
    })
  end

  def options
    {
      plan_identifier: @plan.identifier,
      customer_id:     @user.customer_id,
      expires_at:      expiry_date,
    }
  end

  def discount
    user_discount = @user.discount? ? 0.3 : 0.2

    {
      subitems: [
        {
          description: 'Desconto',
          price_cents: -(@plan.price_in_cents * user_discount).to_i,
          quantity: 1,
          recurrent: false
        }
      ]
    }
  end

  def expiry_date
    year  = Date.today.year
    month = Date.today.month
    day   = Date.today.day

    if day > 25 && month && month == 12
      month = 0 + @plan.duration
      year = year + 1
    elsif day > 25 && (month + @plan.duration) > 12
      month = (month + @plan.duration) - 12
      year = year + 1
    elsif day > 25
      month = month + @plan.duration
    end

    Date.new(year, month, 25)
  end
end
