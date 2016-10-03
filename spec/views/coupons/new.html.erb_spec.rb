require 'rails_helper'

RSpec.describe "coupons/new", type: :view do
  before(:each) do
    assign(:coupon, Coupon.new(
      :code => "MyString",
      :amount => 1.5,
      :quantity => 1
    ))
  end

  it "renders new coupon form" do
    render

    assert_select "form[action=?][method=?]", coupons_path, "post" do

      assert_select "input#coupon_code[name=?]", "coupon[code]"

      assert_select "input#coupon_amount[name=?]", "coupon[amount]"

      assert_select "input#coupon_quantity[name=?]", "coupon[quantity]"
    end
  end
end
