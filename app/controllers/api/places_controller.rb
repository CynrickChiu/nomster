class Api::PlacesController < ApplicationController
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }

  def index
    @places = Place.all
    render json: @places, status: :ok
  end

  def show
    @place = Place.find(params[:id])
    render json: @place
  end

  def update
    @place = Place.find(params[:id])
    if @place.update(place_params)
      head :no_content
    else
      render json: @place.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @place = Place.find(params[:id])
    @place.destroy
    head :no_content
  end

  private

  def default_serializer_options
    {root: false}
  end

  def place_params
    params.require(:place).permit(:name, :address, :description, :user_id, :latitude, :longitude)
  end
end
