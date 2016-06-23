class ResourcesController < ApplicationController
  def index
    category_id = params[:category_id]
    latitude = params[:lat]
    longitude = params[:long]

    if category_id
      relation = resources.joins(:categories).joins(:address).where('categories.id' => category_id)
      relation = location_sort(relation, latitude, longitude)
    end
    present(relation)
  end

  def show
    resource = resources.find(params[:id])
    render json: ResourcesPresenter.present(resource)
  end

  def search
    result = Resources::Search.perform(params.require(:query), scope: resources)
    render json: ResourcesPresenter.present(result)
  end

  private

  def resources
    Resource.includes(:address, :phones, :categories, :notes,
                      schedule: :schedule_days,
                      services: [:notes, { schedule: :schedule_days }])
  end

  def present(relation)
    if relation
      render json: ResourcesPresenter.present(relation)
    else
      render json: {}, status: :bad_request
    end
  end

  def location_sort(relation, latitude, longitude)
    return relation unless latitude && longitude
    relation.order(Address.distance_sql(Geokit::LatLng.new(latitude, longitude)))
  end
end
