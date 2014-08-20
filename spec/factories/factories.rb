FactoryGirl.define do

  factory :place do
    sequence(:name)       {|n| "Example Place #{n}"}
    latitude              50
    longitude             50
    sequence(:location)   {|n| "#{n*100} Main Street"}
  end

end
