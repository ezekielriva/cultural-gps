require 'faker'

puts "# Restoring default"
Admin.delete_all
User.delete_all
Place.delete_all
Event.delete_all

puts "# Creating default users"
Admin.first_or_create(email: 'admin@gps.com', password: '123123123', \
  password_confirmation: '123123123')

User.create(email: 'user@gps.com', password: '123123123', \
  password_confirmation: '123123123')

10.times do
 User.create(email: Faker::Internet.email, password: '123123123', \
  password_confirmation: '123123123')
end

puts "# Creating default places"
places = []
50.times do
  places << Place.create(latitude: Faker::Address.latitude, \
    longitude: Faker::Address.longitude, name: Faker::Name.title )
end

puts "# Creating events"
150.times do
  start_date = (rand(10)+1).days.from_now
  end_date = start_date + (rand(10)+1).days
  Event.create(name: Faker::Name.title, description: Faker::Lorem.sentence, \
    place_id: places.sample.id, start_date: start_date, end_date: end_date )
end
