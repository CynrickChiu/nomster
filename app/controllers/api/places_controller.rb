class Api::PlacesController < ApplicationController
  def index
    @places = Place.all
    render json: @places
  end

  def show
    @place = Place.find(params[:id])
    render json: @place
  end

  private

  def default_serializer_options
    {root: false}
  end

  def place_params
    params.require(:place).permit(:name, :address, :description)
  end
end
