FactoryGirl.define do
  factory :schedule do
    resource nil

    after(:create) do |schedule|
      array = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday","Sunday"]
     
      array.each { |day|
        create(:schedule_day, day: day, schedule: schedule)  
      }

    end
    
  end
end
