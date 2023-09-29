FactoryBot.define do
  factory :user do
    # Add user attributes here
    email { Faker::Internet.email }
    password { 'password123' }
    # Add any other user attributes you need
  end
end
