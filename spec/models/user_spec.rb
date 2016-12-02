require "rails_helper"

RSpec.describe User, type: :model do
  before :each do
    @user = create :user
  end

  it 'should return the main address' do
    @address1 = create :address, main: true
    @address2 = create :address
    @address3 = create :address

    @user.addresses << [@address1, @address2, @address3]

    expect(@user.main_address).to eq(@address1)
  end

  it 'should tell if the user has any subscription' do
    plan = create :plan
    expect(@user.has_any_subscription?).to eq(false)

    @user.plans << plan
    expect(@user.has_any_subscription?).to eq(true)
  end
end
