FactoryGirl.define do

  factory :place do
    sequence(:name)       {|n| "Example Place #{n}"}
    latitude              50
    longitude             50
    sequence(:location)   {|n| "#{n*100} Main Street"}

    factory :wrong_place do
      name          nil
      latitude      nil
      longitude     nil
      location      nil
    end

  end

end
