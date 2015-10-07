class ApplicationController < ActionController::API
  include ActionController::Serialization

  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ActionController::RoutingError, with: :not_found
  rescue_from Errors::BlankHeader, with: :blank_header

  def not_found
    render json: { message: 'Not found' }, status: :not_found
  end

  def blank_header(exception)
    render json: { message: exception.to_s }, status: :unprocessable_entity
  end

  def routing_error
    fail ActionController::RoutingError.new(params[:path])
  end
end
