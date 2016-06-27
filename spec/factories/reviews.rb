FactoryGirl.define do
  factory :review do
    review { Faker::Lorem.paragraph }
    rating nil
  end
end