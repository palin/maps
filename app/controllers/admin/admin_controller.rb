# -*- encoding : utf-8 -*-
class Admin::AdminController < ActionController::Base
  protect_from_forgery

  helper_method :current_user_session, :current_user

  def require_admin
    redirect_to new_admin_user_session_path unless current_user.present?
  end

  private
    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end

    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.user
    end
end
