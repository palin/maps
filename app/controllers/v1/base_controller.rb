class V1::BaseController < ActionController::Base
  respond_to :json

  helper_method :has_cookie?

  def bad_request
    render json: { error: '400 Bad Request' }, status: 400
  end

  def unauthorized
    render json: { error: '401 Unauthorized' }, status: 401
  end

  def forbidden_request
    render json: { error: '403 Forbidden' }, status: 403
  end

  def not_found
    render json: { error: '404 Not Found' }, status: 404
  end

  def unprocessable_entity
    render json: { error: '422 Unprocessable entity' }, status: 422
  end

  def require_admin
    not_found unless current_resource_owner.present? && current_resource_owner.admin?
  end

  def has_cookie?(type, id)
    cookies["#{type}_id_#{id}"].present?
  end

  def cookie_enabled?
    forbidden_request if request.cookies["_reporter_session"].to_s.blank?
  end

  def set_cookie(type, id)
    cookies.permanent["#{type}_id_#{id}"] = id
  end
end
