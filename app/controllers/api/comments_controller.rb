class Api::CommentsController < ApplicationController
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }

  def index
    @place = Place.find(params[:place_id])
    @comments = @place.comments
    render json: @comments, status: :ok
  end

  def create
    @place = Place.find(params[:place_id])
    @comment = @place.comments.new(comment_params)
    if @comment.save
      render json: @comment, status: :created
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def show
    @place = Place.find(params[:place_id])
    @comment = @place.comments.find(params[:id])
    render json: @comment
  end

  def update
    @place = Place.find(params[:place_id])
    @comment = @place.comments.find(params[:id])
    if @comment.update(comment_params)
      head :no_content
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @place = Place.find(params[:place_id])
    @comment = @place.comments.find(params[:id])
    @comment.destroy
    head :no_content
  end

  private

  def default_serializer_options
    {root: false}
  end

  def comment_params
    params.require(:comment).permit(:message, :rating, :user_id)
  end
end
