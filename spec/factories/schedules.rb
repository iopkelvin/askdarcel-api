FactoryGirl.define do
  factory :schedule do
    resource nil

    after(:create) do |schedule|
      array = %w(Monday Tuesday Wednesday Thursday Friday Saturday Sunday)
      array.each do |day|
        create(:schedule_day, day: day, schedule: schedule)
      end
    end
  end
end
