FactoryGirl.define do

  factory :event do
    sequence(:name) {|n| "Example Event #{n}"}
    description     "Example description"
    start_date      Date.today + 1.days
    end_date        Date.today + 2.days
    place
  end

  factory :place do
    sequence(:name)       {|n| "Example Place #{n}"}
    latitude              100
    longitude             100
    sequence(:location)   {|n| "#{n*100} Main Street"}
  end

end
