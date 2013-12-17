require 'spec_helper'

describe Event do

  before(:each) do
    @event = build :event
  end

  subject { @event }

  it { should respond_to :name }
  it { should respond_to :description }
  it { should respond_to :start_date }
  it { should respond_to :end_date }
  it { should respond_to :bearing }
  it { should respond_to :distance }

  describe "end date should not be in the past" do
    before { @event.end_date = @event.start_date.change(year: 1900) }
    it { should_not be_valid }
  end

  describe "Future events" do
    before do
      create_list :event, 5
      @old = build :event, :start_date => Date.new(1900,1,1)
      @old.save(:validate => false)
      @events = Event.get_future_events
    end


    it "should return only future events" do
      @events.should_not include @old
    end

    it "should be order by start_date" do
      @events.first.start_date.should be <= @events.last.start_date
    end

    it "should be less than end of date or quarter" do
      @old.start_date = Date.today
      @old.end_date = Date.today.at_end_of_quarter + 1.days
      @old.save!
      @events = Event.until_date()
      @events.should_not include @old
    end
  end

  describe "Near events" do
    before do
      @places = create_list :place, 2
      @places.cycle(2) {|place| create :event, place: place }

      @places.first.latitude = 20
      @places.first.longitude = 20
      @places.first.save!

      @location = [20.0, 20.0]
    end
    it "should be return only near events" do
      Place.count.should be >= @places.length
      Event.find_near(@location).should include @places.first.events.first
    end
  end

end
