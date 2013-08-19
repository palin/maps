# -*- encoding : utf-8 -*-
class V1::ApiController < ActionController::Base

  respond_to :json

  def render_json(status = 200, data = {})
    if status.is_a?(Hash)
      data = status
      status = 200
    end

    render_json_response(true, status, data)
  end

  def render_error(status, reason = nil, data = {})
    data = data.merge(:reason => reason) if reason

    render_json_response(false, status, data)
  end

  def render_json_response(success, status, data = {})
    response = { :success => success }.merge(data)

    if status.is_a?(Symbol)
      code = Rack::Utils::SYMBOL_TO_STATUS_CODE[status]
      raise "No such HTTP status: #{status}" unless code
    else
      code = status
    end

    if params[:callback]
      render :json => response.merge(:status => code), :callback => params[:callback]
    else
      render :json => response, :status => code
    end
  end

  def not_found
    render_error 404 and return
  end

  def has_cookie?(type, id)
    cookies["#{type}_id_#{id}"].present?
  end

  def cookie_enabled?
    render_error 404, :reason => "Żeby głosować należy włączyć obsługę ciasteczek (cookies)!" if request.cookies["_reporter_session"].to_s.blank?
  end

  def set_cookie(type, id)
    cookies.permanent["#{type}_id_#{id}"] = id
  end
end
