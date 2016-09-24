require "rails_helper"

RSpec.describe User, type: :model do
  before :each do
    @user = create :user
    @address1 = create :address, main: true
    @address2 = create :address
    @address3 = create :address

    @user.addresses << [@address1, @address2, @address3]
  end

  it 'should return the main address' do
    expect(@user.main_address).to eq(@address1)
  end
end
