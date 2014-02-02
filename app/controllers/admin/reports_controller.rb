# -*- encoding : utf-8 -*-
class Admin::ReportsController < Admin::AdminController

  expose(:reports) { Report.order(sort_column("Report") + " " + sort_direction).page(params[:page] || 1).per(params[:per_page] || 10) }
  expose(:report) { Report.find(params[:id]) }

  rescue_from ActiveRecord::RecordNotFound, with: :no_record_handler

  def destroy
    if report.destroy
      flash[:notice] = "Zgłoszenie zostało usunięte!"
    else
      flash.now[:alert] = "Nie można usunąć zgłoszenia!"
    end

    redirect_to admin_reports_path
  end

  def update
    if report.update_attributes(report_params)
      flash[:notice] = "Zgłoszenie zostało zaktualizowane!"
      redirect_to admin_reports_path
    else
      flash[:alert] = "Wystąpił problem. Sprawdź dane formularza."
      render :edit
    end
  end

  private

  def report_params
    params.require(:report).permit(:title, :description, :photo, :category_id, :latitude, :longitude)
  end

  def no_record_handler
    flash[:alert] = "Nie znaleziono takiego zgłoszenia"
    redirect_to admin_reports_path
  end
end
