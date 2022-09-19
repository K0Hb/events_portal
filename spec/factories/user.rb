FactoryBot.define do
  factory :user do
    name { "test_name_#{rand(999)}" }
    sequence(:email) { |n| "test#{n}@test.ru" }
    after(:build) { |u| u.password_confirmation = u.password = 'qwerty' }
  end
end
