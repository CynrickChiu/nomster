class Api::PlacesController < ApplicationController
  def index
    @places = Place.all
    render json: @places
  end

  def default_serializer_options
    {root: false}
  end
end
