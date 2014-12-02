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

  describe "Future events" do
    before do
      create_list :events_starts_today, 5
      @old = create :event, start_date: Date.new(1900,1,1), end_date: Date.new(1900,1,1)
      @events = Event.get_future_events
    end

    it { expect(@events).not_to include @old }
    it { expect(@events.first.start_date).to be <= @events.last.start_date }

    it "should be less than end of date or quarter" do
      @old.start_date = Date.today
      @old.end_date = Date.today.at_end_of_quarter + 1.days
      @old.save!
      @events = Event.until_date()
      @events.should_not include @old
    end
  end

end
