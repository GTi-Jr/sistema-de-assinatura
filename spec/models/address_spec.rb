require "rails_helper"

RSpec.describe Address, type: :model do
  before :each do
    @user = create :user
    @address1 = create :address, main: true
    @address2 = create :address
    @address3 = create :address

    @user.addresses << [@address1, @address2, @address3]
  end

  it 'should change the main address' do
    @address2.become_main

    @address1 = Address.find @address1.id 
    @address2 = Address.find @address2.id 
    @address3 = Address.find @address3.id 

    expect(@address2.main).to eq(true)
    expect(@address1.main).to eq(false)
    expect(@address3.main).to eq(false)
  end
end
