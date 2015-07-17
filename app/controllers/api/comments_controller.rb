class Api::CommentsController < ApplicationController
  def index
    @place = Place.find(params[:place_id])
    @comments = @place.comments
    render json: @comments
  end

  def show
    @place = Place.find(params[:place_id])
    @comment = @place.comments.find(params[:id])
    render json: @comment
  end

  def default_serializer_options
    {root: false}
  end
end
