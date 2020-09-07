FactoryBot.define do
  factory :feedback do
    rating { 1 }
    review { "MyText" }
    feedbackable_id { 1 }
    feedbackable_type { "MyString" }
  end
end
