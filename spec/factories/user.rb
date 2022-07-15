# frozen_string_literal: true

require 'securerandom'

FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { Faker::Password.password }
    password_confirmation { Faker::Password.password_confirmation}
    profile { %i[admin client].sample }
  end
end
