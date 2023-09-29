FactoryBot.define do
  factory :recipe do
    name { Faker::Food.dish }
    description { Faker::Lorem.sentence }
    user
    # Add any other recipe attributes you need
  end
end
