require "paypal/recurring"

PayPal::Recurring.configure do |config|
  config.sandbox = true
  config.username = ENV['PAYPAL_USERNAME']
  config.password = ENV['PAYPAL_PASSWORD']
  config.signature = ENV['PAYPAL_SIGNATURE']
end
