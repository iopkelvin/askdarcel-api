class ApplicationController < ActionController::API
  rescue_from ActionController::ParameterMissing do
    render nothing: true, status: :bad_request
  end

  private

  def require_authorization!
    head :unauthorized unless current_user
  end

  def current_user
    return @current_user if defined? @current_user
    user_id = request.headers['Authorization']
    @current_user = User.where(id: user_id).first
  end
end
