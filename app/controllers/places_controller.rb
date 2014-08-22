class PlacesController < ApplicationController
  before_filter :authenticate_admin!, :except => [:index, :show]

  expose(:places)
  expose(:place, attributes: :place_params)

  has_scope :search_name, as: :q

  def index; end
  def show; end
  def new; end
  def edit; end

  def create
    respond_to do |format|
      if place.save
        format.html { redirect_to place, notice: 'Place was successfully created.' }
        format.json { render action: 'show', status: :created, location: place }
      else
        format.html { render action: 'new' }
        format.json { render json: place.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if place.update(place_params)
        format.html { redirect_to place, notice: 'Place was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: place.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    place.destroy
    respond_to do |format|
      format.html { redirect_to places_url }
      format.json { head :no_content }
    end
  end

  private
    def place_params
      params.require(:place).permit(:name, :latitude, :longitude, :description)
    end
end
