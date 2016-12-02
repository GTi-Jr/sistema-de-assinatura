module ApplicationHelper
  def current_path
    request.fullpath
  end

  def flash_message_color(key)
    return 'warning' if key == 'alert'
    return 'success' if key == 'notice'
  end

  def currency(price)
    number_to_currency(price, unit: 'R$', separator: ',', delimiter: '')
  end

  def discount(price, percentage)
    price - (price * percentage / 100)
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
end
