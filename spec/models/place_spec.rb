require 'spec_helper'

describe Place do

  before(:each) do
    @place = Place.new(name: 'Example Place', longitude: 1.01, latitude: 1.01)
  end

  subject { @place }

  it { should respond_to :name }
  it { should respond_to :latitude }
  it { should respond_to :longitude }
  it { should respond_to :description }
  it { should be_valid }

end
