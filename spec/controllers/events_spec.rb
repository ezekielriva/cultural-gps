require 'spec_helper'

describe EventsController do
  before(:each) do
    @admin = create :admin
    sign_in :admin, @admin
  end

  describe "GET #index" do
    before do
      @old = create_list :older_event, 2
      @events = create_list :event, 2
      @events << create(:started_events)
      get :index
    end

    it { expect( response.status ).to eq 200 }
    it { expect( controller.future_events ).to include @events.first }
    it { expect( controller.future_events ).not_to include @old }
    it { expect( controller.future_events.count ).to eql 3 }
  end

  describe "GET #new" do
    before { get :new }
    it { expect( controller.event.new_record? ).to be_true }
  end

  describe "POST #create" do
    before { Event.any_instance.stub(:geocode).and_return([1,1]) }
    describe "with valid data" do
      before { post :create, event: attributes_for(:event), format: 'html' }

      it { expect( Event.count ).to eql 1 }
      it { expect( response.status ).to eql 302 }
    end

    describe "with invalid data" do
      before { post :create, event: { invalid: true }, format: 'html' }

      it { expect( Event.count ).to eql 0 }
      it { expect( response.status ).to eql 200 }
    end
  end

  describe "PUT #update" do
    before do
      @event = create :event
      Event.any_instance.stub(:geocode).and_return([1,1])
    end

    describe "with valid data" do
      before { put :update, event: { name: 'New name' }, id: @event.id }

      it { expect( Event.find(@event.id).name ).to eql 'New name' }
      it { expect( response.status ).to eql 302 }
    end

    describe "with invalid data" do
      before { put :update, event: { name: nil }, id: @event.id }

      it { expect( Event.last ).to eql @event }
      it { expect( response.status ).to eql 200 }
    end
  end

  describe "DELETE #destroy" do
    before do
      @event = create :event
      delete :destroy, id: @event.id
    end

    it { expect( Event.where(id: @event.id) ).not_to exist }
  end

end
