module DiscountHelper
  def user_discount(user)
    return 20 if user.nil?
    return 20 if user.discount.nil?
    user.discount
  end
end
