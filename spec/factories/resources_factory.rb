FactoryGirl.define do
  factory :resource do
    name { Faker::Company.name }
  end
end
