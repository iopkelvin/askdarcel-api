# frozen_string_literal: true

FactoryBot.define do
  factory :bookmark do
    identifier { Faker::Lorem.name }
    date_value { 20.years.ago }
    id_value { 0 }
  end
end
