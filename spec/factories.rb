FactoryGirl.define do
  factory :file_import do
    user
  end

  sequence :email do |n|
    "email#{n}@factory.com"
  end

  factory :user do
    name "Amyr"
    email 
  end

  factory :merchant do
    name "John Doe"
    address "123 Fake St"
  end

  factory :item do
    price 4.0
    description "Something"
  end

  factory :purchaser do
    name "Simon Buymore"
  end

  factory :purchase do
    file_import
    merchant
    item
    purchaser
    count "2"
  end

end
