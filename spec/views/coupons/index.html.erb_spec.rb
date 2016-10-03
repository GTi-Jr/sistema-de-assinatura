require 'rails_helper'

RSpec.describe "coupons/index", type: :view do
  before(:each) do
    assign(:coupons, [
      Coupon.create!(
        :code => "Code",
        :amount => 2.5,
        :quantity => 3
      ),
      Coupon.create!(
        :code => "Code",
        :amount => 2.5,
        :quantity => 3
      )
    ])
  end

  it "renders a list of coupons" do
    render
    assert_select "tr>td", :text => "Code".to_s, :count => 2
    assert_select "tr>td", :text => 2.5.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
