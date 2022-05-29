FactoryBot.define do
  factory :product do
    sequence(:name) { |n| "Category #{n}" }
    description { Faker::Lorem.paragraph }
    price { Faker::Commer.price(rage: 100.0..400.0) }
    productable { nil }
  end
end
