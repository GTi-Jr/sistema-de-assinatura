FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "Testing John #{n}" }
    sequence(:email) { |n| "test_user_#{n}@test.com" }
    password "123456789"
    password_confirmation "123456789"
    rg "9999999999999"
    cpf "604.771.534-61" # Random valid CPF
    birthdate { 20.years.ago }
    phone "(99) 99999-9999"
    complete true
  end

  factory :address do
    state "State"
    city "City"
    street "Street"
    number 999
    zipcode "99999-999"
    main false
  end
end
