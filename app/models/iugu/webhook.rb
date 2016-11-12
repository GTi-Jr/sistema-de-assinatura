module Iugu::Webhook
  def process(event, data)
    case event
    when 'subscription.suspended' then subscription_suspended(data)
    end
  end

  private

  def subscription_suspended(data = {})
  end

end
