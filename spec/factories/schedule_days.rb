FactoryGirl.define do
  factory :schedule_day do
    day nil
    opens_at { Faker::Number.positive(6, 10) }
    closes_at { Faker::Number.positive(14, 24) }
    schedule nil
  end
end
