class ResourcesController < ApplicationController
  def index
    category_id = params[:category_id]
    result = if category_id
               resources.joins(:categories).where('categories.id' => category_id)
             else
               Resource.all
             end

    render json: result.to_json(resource_inclusion)
  end

  def show
    resource = resources.find(params[:id])
    render json: resource.to_json(resource_inclusion)
  end

  private

  def resources
    Resource.includes(:addresses, :phones, :categories,
                      schedule: :schedule_days)
  end

  def resource_inclusion
    schedule_attrs = { include: :schedule_days }
    service_attrs = { include: [:notes, schedule: schedule_attrs] }
    {
      include: [:addresses, :phones, :categories, :notes, {
        services: service_attrs
      }, {
        schedule: schedule_attrs
      }]
    }
  end
end
