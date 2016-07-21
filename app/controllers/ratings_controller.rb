class RatingsController < ApplicationController
  before_action :require_authorization!

  def create
    rating = resource.ratings.create!(rating_params)
    render status: :created, json: RatingPresenter.present(rating)
  end

  private

  def rating_params
    @rating_params ||= params.require(:rating).permit(
      :rating
    ).merge(user: current_user, review: review)
  end

  def review
    @review ||= Review.new params.require(:rating).permit(:review)
  end

  def resource
    @resource ||= Resource.find params.require(:resource_id)
  end
end
