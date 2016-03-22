namespace :db do
  desc 'Erase and fill a development database'
  task populate: :environment do
    unless Rails.env.development?
      puts 'db:populate task can only be run in development.'
      exit
    end

    [Category, Resource].each(&:delete_all)

    FactoryGirl.create_list :category, 20

    categories = Category.all

    128.times do
      name = Faker::Company.name
      short_description = Faker::Lorem.sentence if rand(2) == 0
      long_description = Faker::Lorem.paragraph if rand(2) == 0
      website = Faker::Internet.url if rand(2) == 0

      FactoryGirl.create(:resource,
                         name: name,
                         short_description: short_description,
                         long_description: long_description,
                         website: website,
                         categories: categories.sample(rand(4)))
    end
  end
end
