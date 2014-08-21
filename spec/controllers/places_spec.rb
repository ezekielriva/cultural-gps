require 'spec_helper'

describe PlacesController do
  before(:each) do
    @admin = create :admin
    sign_in :admin, @admin
  end

  describe "GET #index" do
    before do
      @places = create_list :place, 10
      get :index
    end

    it { expect( response.status ).to eq 200 }
    it { expect( assigns(:places) ).to eq @places }
    it { expect( assigns(:places).count ).to eql 10 }
  end

  describe "POST #create" do
    before { Place.any_instance.stub(:geocode).and_return([1,1]) }
    describe "with valid data" do
      before { post :create, place: attributes_for(:place), format: 'html' }

      it { expect( Place.count ).to eql 1 }
      it { expect( response.status ).to eql 302 }
    end

    describe "with invalid data" do
      before { post :create, place: attributes_for(:wrong_place), format: 'html' }

      it { expect( Place.count ).to eql 0 }
      it { expect( response.status ).to eql 200 }
    end
  end

  describe "PUT #update" do
    before do
      @place = create :place
      Place.any_instance.stub(:geocode).and_return([1,1])
    end

    describe "with valid data" do
      before { put :update, place: { name: 'New name' }, id: @place.id }

      it { expect( Place.find(@place.id).name ).to eql 'New name' }
      it { expect( response.status ).to eql 302 }
    end

    describe "with invalid data" do
      before { put :update, place: { name: nil }, id: @place.id }

      it { expect( Place.last ).to eql @place }
      it { expect( response.status ).to eql 200 }
    end
  end

  describe "DELETE #destroy" do
    before do
      @place = create :place
      delete :destroy, id: @place.id
    end

    it { expect( Place.where(id: @place.id) ).not_to exist }
  end

end
