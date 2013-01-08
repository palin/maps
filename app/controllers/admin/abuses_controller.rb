# -*- encoding : utf-8 -*-
class Admin::AbusesController < Admin::AdminController

  before_filter :require_admin
  before_filter :find_abuse, :except => [:index]

  def index
    @abuses = Abuse.order(sort_column("Abuse") + " " + sort_direction).page(params[:page]).per(10)
  end

  def destroy
    if @abuse.destroy
      flash[:notice] = "Zgłoszenie nadużycia zostało usunięte!"
    else
      flash.now[:alert] = "Nie można usunąć zgłoszenia nadużycia!"
    end

    redirect_to admin_abuses_path and return
  end

  private

  def find_abuse
    @abuse = Abuse.find_by_id(params[:id])
    unless @abuse
      flash[:alert] = "Nie znaleziono takiego zgłoszenia nadużycia"
      redirect_to admin_reports_path and return
    end
  end
end
