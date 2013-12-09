class CollectDecorator
  def places_data
    Place.all.collect { |place| [place.name, place.id] }
  end
end
