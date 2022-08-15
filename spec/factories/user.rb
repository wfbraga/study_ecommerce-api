# frozen_string_literal: true

FactoryBot.define do
  password = Faker::Internet.password
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { password }
    password_confirmation { password }
    profile { :admin }
  end
end
