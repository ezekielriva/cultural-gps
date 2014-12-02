FactoryGirl.define do

  factory :event do
    sequence(:name) {|n| "Example Event #{n}"}
    description     "Example description"
    start_date      Time.zone.now + 2.hours
    end_date        Time.zone.now + 3.hours
    place

    factory :events_starts_today do
      start_date      Time.zone.now + 1.days
      end_date        Time.zone.now + 2.days
    end

    factory :started_events do
      start_date      Time.zone.now - 1.days
      end_date        Time.zone.now + 1.days
    end

    factory :older_event do
      start_date      Time.zone.now - 2.days
      end_date        Time.zone.now - 2.days
    end
  end

end
