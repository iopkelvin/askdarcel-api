FactoryGirl.define do
  factory :category do
    sequence(:name) { |n| Faker::Lorem.words(1).first + n.to_s }
  end
end
