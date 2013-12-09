require 'spec_helper'

describe Event do

  before(:each) do
    @event = Event.new(name: "Example event", description: "Example description",
                       start_date: DateTime.new, end_date: DateTime.new )
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

end
