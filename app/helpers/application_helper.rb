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
end
