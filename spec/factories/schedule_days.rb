FactoryGirl.define do
  factory :schedule_day do
    day nil
    opens_at { Faker::Number.positive(from=6, to=10) }
    closes_at { Faker::Number.positive(from=14, to=24) }
    schedule nil
  end
end
