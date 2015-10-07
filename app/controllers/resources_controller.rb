class ResourcesController < ApplicationController
  before_action :set_resource, only: [:show, :update, :destroy]

  # GET /resources
  # GET /resources.json
  def index
    @resources = Resource.page(params[:page]).per(params[:per_page])

    if params['category_names']
      @resources = @resources.joins(:categories).where('categories.name IN (?)', params['category_names'])
    end

    if params['category_ids']
      @resources = @resources.joins(:categories).where('categories.id IN (?)', params['category_ids'])
    end

    render json: @resources,
           include: [:phone_numbers, :categories, :addresses, :resource_images],
           serializer: PaginatedSerializer,
           device_id: device_id
  end

  # GET /resources/1
  # GET /resources/1.json
  def show
    render json: @resource, include: [:phone_numbers, :categories, :addresses, :resource_images], device_id: device_id
  end

  private

  def device_id
    request.headers['DEVICE-ID']
  end

  def set_resource
    @resource = Resource.find(params[:id])
  end

  def resource_params
    params.require(:resource).permit(:page_id, :title, :email, :summary, :content, :website)
  end
end
