# require 'spec_helper'

# describe "places/new" do
#   before(:each) do
#     assign(:place, stub_model(Place,
#       :name => "MyString",
#       :latitude => "9.99",
#       :longitude => "9.99",
#       :description => "MyString"
#     ).as_new_record)
#   end

#   it "renders new place form" do
#     render

#     # Run the generator again with the --webrat flag if you want to use webrat matchers
#     assert_select "form[action=?][method=?]", places_path, "post" do
#       assert_select "input#place_name[name=?]", "place[name]"
#       assert_select "input#place_latitude[name=?]", "place[latitude]"
#       assert_select "input#place_longitude[name=?]", "place[longitude]"
#       assert_select "input#place_description[name=?]", "place[description]"
#     end
#   end
# end
