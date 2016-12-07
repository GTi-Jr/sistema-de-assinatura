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

  def due_day
    @due_day || 25
  end

  def due_day=(day)
    @due_day = day
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
    {
      subitems: [
        {
          description: 'Desconto',
          price_cents: -(@plan.price_in_cents * @user.discount).to_i,
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

    if day > due_day && month && month == 12
      month = 0 + @plan.duration
      year = year + 1
    elsif day > due_day && (month + @plan.duration) > 12
      month = (month + @plan.duration) - 12
      year = year + 1
    elsif day > due_day
      month = month + @plan.duration
    end

    Date.new(year, month, due_day)
  end
end
