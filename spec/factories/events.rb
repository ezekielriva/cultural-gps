FactoryGirl.define do

  factory :event do
    sequence(:name) {|n| "Example Event #{n}"}
    description     "Example description"
    place

    factory :events_starts_today do
      start_date      Time.zone.now + 1.days
      end_date        Time.zone.now + 2.days
    end

    factory :started do
      start_date      Time.zone.now - 1.days
      end_date        Time.zone.now + 1.days
    end
  end

end
