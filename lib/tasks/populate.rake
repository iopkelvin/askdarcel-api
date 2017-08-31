namespace :db do
  desc 'Erase and fill a development database'
  task populate: :environment do
    unless Rails.env.development? || Rails.env.test?
      puts 'db:populate task can only be run in development or test.'
      exit
    end

    require 'faker/sheltertech'

    Rails.application.eager_load! # Load all models
    ActiveRecord::Base.transaction do
      ActiveRecord::Base.descendants.each do |model|
        next if model.to_s.starts_with? 'ActiveRecord::'
        model.destroy_all
        ActiveRecord::Base.connection.reset_pk_sequence!(model.table_name)
      end
    end

    category_names = %w[Shelter Food Medical Hygiene Technology]
    category_names.each { |name| FactoryGirl.create(:category, name: name, top_level: true) }

    categories = Category.all

    FactoryGirl.create(:admin)

    128.times do
      name = Faker::Company.name
      short_description = Faker::Lorem.sentence if rand(2) == 0
      long_description = Faker::ShelterTech.description
      website = Faker::Internet.url if rand(2) == 0
      resource = FactoryGirl.create(:resource,
                                    name: name,
                                    short_description: short_description,
                                    long_description: long_description,
                                    website: website,
                                    categories: categories.sample(rand(4)))
      services = []

      (rand(2) + 1).times do
        services << FactoryGirl.create(:service,
                                       resource: resource,
                                       long_description: Faker::ShelterTech.description)

        FactoryGirl.create(:change_request,
                           type: 'ResourceChangeRequest',
                           status: ChangeRequest.statuses[:pending],
                           object_id: resource.id)
      end

      resource.services = services
    end
  end
end
