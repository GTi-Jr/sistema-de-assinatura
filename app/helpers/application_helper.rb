module ApplicationHelper
  def flash_message_color(key)
    return 'warning' if key == 'alert'
    return 'success' if key == 'notice'
  end
end
