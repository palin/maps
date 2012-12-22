# -*- encoding : utf-8 -*-
class Admin::UserSessionsController < Admin::AdminController

  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      redirect_to admin_panel_index_path, :notice => "Poprawnie zalogowano!"
    else
      flash[:alert] = "Niepoprawne dane logowania!"
      render :new
    end
  end

  def destroy
    current_user_session.destroy
    redirect_to root_path, :notice => "Pomyślnie wylogowano!"
  end
end
