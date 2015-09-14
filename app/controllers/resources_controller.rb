class ResourcesController < ApplicationController
  before_action :set_resource, only: [:show, :update, :destroy]

  # GET /resources
  # GET /resources.json
  def index
    @resources = Resource.page(params[:page]).per(params[:per_page])

    if params["category_names"]
      @resources = @resources.joins(:categories).where('categories.name IN (?)', params["category_names"])
    end

    render json: @resources,
           include: [:phone_numbers, :categories, :addresses],
           serializer: PaginatedSerializer
  end

  # GET /resources/1
  # GET /resources/1.json
  def show
    render json: @resource, include: [:phone_numbers, :categories, :addresses]
  end

  # POST /resources
  # POST /resources.json
  def create
    @resource = Resource.new(resource_params)

    if @resource.save
      render json: @resource, include: [:phone_numbers, :categories, :addresses], status: :created, location: @resource
    else
      render json: @resource.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /resources/1
  # PATCH/PUT /resources/1.json
  def update
    @resource = Resource.find(params[:id])

    if @resource.update(resource_params)
      head :no_content
    else
      render json: @resource.errors, status: :unprocessable_entity
    end
  end

  # DELETE /resources/1
  # DELETE /resources/1.json
  def destroy
    @resource.destroy

    head :no_content
  end

  private

  def set_resource
    @resource = Resource.find(params[:id])
  end

  def resource_params
    params.require(:resource).permit(:page_id, :title, :email, :summary, :content, :website)
  end
end
