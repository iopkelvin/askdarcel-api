# frozen_string_literal: true

FactoryBot.define do
  factory :feedback do
    rating { 1 }
    review { "MyText" }
    resource { nil }
    service { nil }
  end
end
