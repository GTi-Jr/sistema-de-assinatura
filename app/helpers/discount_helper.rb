module DiscountHelper
  def user_discount(user)
    return 20 if user.nil?
    user.discount? ? 30 : 20
  end
end
