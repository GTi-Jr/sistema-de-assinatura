require 'rails_helper'

RSpec.describe "coupons/show", type: :view do
  before(:each) do
    @coupon = assign(:coupon, Coupon.create!(
      :code => "Code",
      :amount => 2.5,
      :quantity => 3
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Code/)
    expect(rendered).to match(/2.5/)
    expect(rendered).to match(/3/)
  end
end
