# -*- encoding : utf-8 -*-
class Admin::AbusesController < Admin::AdminController

  expose(:abuses) { Abuse.order(sort_column("Abuse") + " " + sort_direction).page(params[:page] || 1).per(params[:per_page] || 10) }
  expose(:abuse)

  rescue_from ActiveRecord::RecordNotFound, with: :no_record_handler

  def destroy
    if abuse.destroy
      flash[:notice] = "Zgłoszenie nadużycia zostało usunięte!"
    else
      flash.now[:alert] = "Nie można usunąć zgłoszenia nadużycia!"
    end

    redirect_to admin_abuses_path
  end

  private

  def no_record_handler
    flash[:alert] = "Nie znaleziono takiego zgłoszenia nadużycia"
    redirect_to admin_abuses_path
  end
end
