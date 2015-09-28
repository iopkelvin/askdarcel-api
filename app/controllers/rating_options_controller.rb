class RatingOptionsController < ApplicationController
  # GET /rating_options
  # GET /rating_options.json
  def index
    @rating_options = RatingOption.all

    render json: @rating_options
  end
end
