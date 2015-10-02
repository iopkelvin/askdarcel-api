class RatingsController < ApplicationController
  before_action :require_device_id

  before_action :set_rating, only: [:show, :update, :destroy]

  # GET /ratings
  # GET /ratings.json
  def index
    @ratings = Rating.created_by(device_id)
    render json: @ratings
  end

  # GET /ratings/1
  # GET /ratings/1.json
  def show
    render json: @rating
  end

  # POST /ratings
  # POST /ratings.json
  def create
    @rating = Rating.new(
      resource_id: params[:rating][:resource_id],
      device_id: device_id,
      rating_option_attributes: {name: params[:rating][:rating_option_name]},
    )

    if @rating.save
      render json: @rating, status: :created
    else
      render json: @rating.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /ratings/1
  # PATCH/PUT /ratings/1.json
  def update
    if @rating.update(
        resource_id: params[:rating][:resource_id],
        device_id: device_id,
        rating_option_attributes: {name: params[:rating][:rating_option_name]})
      render json: @rating, status: :ok
    else
      render json: @rating.errors, status: :unprocessable_entity
    end
  end

  # DELETE /ratings/1
  # DELETE /ratings/1.json
  def destroy
    @rating.destroy

    head :no_content
  end

  private
  def require_device_id
    if device_id.blank?
      raise Errors::BlankHeader.new('DEVICE-ID')
    end
  end

  def device_id
    request.headers['DEVICE-ID']
  end

  def set_rating
    @rating = Rating.created_by(device_id).find(params[:id])
  end

  def rating_params
    params[:rating][:rating_option_attributes] = {name: params[:rating_option_name]}
    params.require(:rating).permit(:resource_id, :rating_option_attributes).merge(
      device_id: device_id,
    )
  end
end
