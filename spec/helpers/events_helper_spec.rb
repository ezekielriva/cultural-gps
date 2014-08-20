require 'spec_helper'

describe EventsHelper do
  describe "#has_started_class" do
    it { expect(helper.has_started_class Time.now - 1.day ).to eql 'active' }
    it { expect(helper.has_started_class Time.now + 1.day ).to eql nil }
  end

  describe "#place_direction_class" do
    before do
      @north_bearing  = 180
      @south_bearing  = 0
      @east_bearing   = 270
      @west_bearing   = 90
    end

    it { expect(helper.place_direction_class @north_bearing ).to eql 'icon-arrow-up' }
    it { expect(helper.place_direction_class @south_bearing ).to eql 'icon-arrow-down' }
    it { expect(helper.place_direction_class @east_bearing ).to eql 'icon-arrow-right' }
    it { expect(helper.place_direction_class @west_bearing ).to eql 'icon-arrow-left' }
  end

  describe "#place_direction" do
    before do
      @north_bearing  = 180
      @south_bearing  = 0
      @east_bearing   = 270
      @west_bearing   = 90
    end

    it { expect(helper.place_direction @north_bearing ).to eql 'N' }
    it { expect(helper.place_direction @south_bearing ).to eql 'S' }
    it { expect(helper.place_direction @east_bearing ).to eql 'E' }
    it { expect(helper.place_direction @west_bearing ).to eql 'W' }
  end

  describe "#normalize_distance" do
    before do
      @kilometers = 1000
      @meters     = 100
    end

    it { expect(helper.normalize_distance @kilometers ).to eql "1 km" }
    it { expect(helper.normalize_distance @meters ).to eql "100 m" }
  end
end
