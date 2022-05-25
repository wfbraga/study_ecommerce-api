FactoryBot.define do
  factory :system_requirement do
    sequence(:name) { |n| "System Req #{n}" }
    operational_system { Faker::Computer.os }
    storage { "500gb" }
    processor { "AMD Ryzen 7" }
    memory { "8Gb" }
    video_board { "GForce 4Gb" }
  end
end
