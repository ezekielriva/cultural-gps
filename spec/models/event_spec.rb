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
      # Six because we should count extra entry by beginning before statment
      @events.should_not include @old
    end

    it "should be order by start_date" do
      @events.first.start_date.should be <= @events.last.start_date
    end
  end

  describe "Near events" do
    it "should be return only near events" do
      places = create_list :place, 2
      places.cycle(4) {|place| create :event, :place => place }
      events = Event.find_near([100,100])
      events.length.should be == 1
    end
  end

end
