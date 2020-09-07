# frozen_string_literal: true

FactoryBot.define do
  factory :feedback do
    rating { 1 }
    review { "MyText" }
    reviewable_id { 1 }
    reviewable_type { "MyString" }
  end
end
