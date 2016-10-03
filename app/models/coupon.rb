class Coupon < ActiveRecord::Base

  def value
    if coupon_type == "fixo"
      amount
    else
      amount/100
    end

  end

  def check_quantity
    quantity >=1
  end

  def fix_discount?
    coupon_type == "fixo"
  end


  def used_coupon!
    self.quantity = self.quantity - 1
    self.save
  end

  def  self.apply(name,plan)

    coupon= Coupon.find_by(code: name)
    if coupon.check_quantity
      discount = coupon.value

      if coupon.fix_discount?
        value=plan.price - discount
        coupon.used_coupon!
      else
        value =plan.price - (plan.price*discount)
        coupon.used_coupon
      end
      value

    else
      nil
    end

  end

end
