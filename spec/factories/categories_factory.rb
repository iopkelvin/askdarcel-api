FactoryGirl.define do
  factory :category do
    name { Faker::Lorem.words(1).first }
  end
end
