FactoryBot.define do
  factory :coupon do
    code { Faker::Commerce.unique.promotion_code(digits: 6) }
    status { %i[actitve inactive].sample }
    discount_value { rand(100) }
    due_date { "2022-07-15 07:52:57" }
  end
end
