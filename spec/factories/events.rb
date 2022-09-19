FactoryBot.define do
  factory :event do
    association :user
    title { "Name #{rand(999)}" }
    address { "Address #{rand(999)}"}
    datetime { Time.now }
  end
end
