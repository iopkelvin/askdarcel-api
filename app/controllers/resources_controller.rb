class ResourcesController < ApplicationController
  def index
    category_id = params[:category_id]
    resources = if category_id
                  Resource.joins(:categories).where('categories.id' => category_id)
                else
                  Resource.all
                end
    render json: resources.to_json(RENDERED_RESOURCE_ATTRIBUTES)
  end

  def show
    resource = Resource.find(params[:id])
    render json: resource.to_json(RENDERED_RESOURCE_ATTRIBUTES)
  end

  # rubocop:disable MutableConstant
  RENDERED_SCHEDULE_ATTRIBUTES = {
    include: 'schedule_days'
  }

  RENDERED_SERVICE_ATTRIBUTES = {
    include: ['notes', { schedule: RENDERED_SCHEDULE_ATTRIBUTES }]
  }

  RENDERED_RESOURCE_ATTRIBUTES = {
    include: ['addresses', 'phones', 'categories', 'notes', {
      services: RENDERED_SERVICE_ATTRIBUTES
    }, {
      schedule: RENDERED_SCHEDULE_ATTRIBUTES
    }]
  }
  # rubocop:enable MutableConstant
end
