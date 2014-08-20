require 'spec_helper'

describe "Events" do

  describe "when list them" do
    before { @events = create_list :event, 31 }
    it "should response a lot of events" do
      get events_path
      #expect(response).to render_template(:index)

      #expect( assigns(:events).count ).to eql(30)
    end

  end

end
