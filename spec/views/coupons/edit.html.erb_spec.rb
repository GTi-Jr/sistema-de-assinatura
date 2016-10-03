require 'rails_helper'

RSpec.describe "coupons/edit", type: :view do
  before(:each) do
    @coupon = assign(:coupon, Coupon.create!(
      :code => "MyString",
      :amount => 1.5,
      :quantity => 1
    ))
  end

  it "renders the edit coupon form" do
    render

    assert_select "form[action=?][method=?]", coupon_path(@coupon), "post" do

      assert_select "input#coupon_code[name=?]", "coupon[code]"

      assert_select "input#coupon_amount[name=?]", "coupon[amount]"

      assert_select "input#coupon_quantity[name=?]", "coupon[quantity]"
    end
  end
end
