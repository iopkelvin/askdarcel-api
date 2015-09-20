FactoryGirl.define do
  sequence(:page_id)
  sequence(:name) { |n| "Example #{n}" }

  factory :resource do
    title { Faker::Company.name }
    summary { Faker::Lorem.paragraph }
    page_id
    content { Faker::Lorem.paragraphs(3).join("\n") }
    email { Faker::Internet.email }
    website { Faker::Internet.url }

    transient do
      categories_count 3
      phone_numbers_count 1
      addresses_count 1
      resource_images_count 1
    end

    after(:create) do |resource, evaluator|
      create_list(:category, evaluator.categories_count, resources: [resource])
      create_list(:phone_number, evaluator.phone_numbers_count, resource: resource)
      create_list(:address, evaluator.addresses_count, resource: resource)
      create_list(:resource_image, evaluator.resource_images_count, resource: resource)
    end
  end

  factory :category do
    name
  end

  factory :address do
    street1 { Faker::Address.street_address }
    street2 { Faker::Address.secondary_address }
    city { Faker::Address.city }
    state { Faker::Address.state }
    postal_code { Faker::Address.postcode }
    country { Faker::Address.country }
    longitude { Faker::Address.longitude }
    latitude { Faker::Address.latitude }

    full_street_address { "#{Faker::Address.street_address}, #{Faker::Address.city}, #{Faker::Address.state}, #{Faker::Address.postcode}, #{Faker::Address.country}" }
  end

  factory :phone_number do
    country_code { Faker::Number.number(3) }
    area_code { Faker::Number.number(3) }
    number { Faker::Number.number(7) }
    extension { Faker::Number.number(2) }
    comment { Faker::Lorem.sentence }
  end

  factory :resource_image do
    caption { Faker::Lorem.sentence }
    photo_file_name { Faker::Internet.url }
    photo_content_type "image/jpeg"
    photo_file_size { Faker::Number.number(5) }
  end
end
