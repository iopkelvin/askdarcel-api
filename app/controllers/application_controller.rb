class ApplicationController < ActionController::API
  include ActionController::Serialization

  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ActionController::RoutingError, with: :not_found

  def not_found
    render json: { message: "Not found" }, status: :not_found
  end

  def routing_error
    raise ActionController::RoutingError.new(params[:path])
  end
end
