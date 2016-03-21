class ResourcesController < ApplicationController
  def index
    category_id = params[:category_id]
    @resources = if category_id
                   Resource.joins(:categories).where('categories.id' => category_id)
                 else
                   Resource.all
                 end

    render json: @resources
  end
end
