# -*- encoding : utf-8 -*-
class Admin::ReportsController < Admin::AdminController

  expose(:reports) { Report.order(sort_column("Report") + " " + sort_direction).page(params[:page] || 1).per(params[:per_page] || 10) }
  expose(:report) { Report.find_by_id(params[:id]) }

  before_filter :find_report, :except => [:index]

  def index
  end

  def destroy
    if report.destroy
      flash[:notice] = "Zgłoszenie zostało usunięte!"
    else
      flash.now[:alert] = "Nie można usunąć zgłoszenia!"
    end

    redirect_to admin_reports_path
  end

  def edit
  end

  def update
    if params[:report][:category_id].present?
      category = Category.find_by_unique_id(params[:report][:category_id])
      params[:report][:category_id] = category.id
    end

    report.assign_attributes(report_params)

    if report.save
      flash[:notice] = "Zgłoszenie zostało zaktualizowane!"
      redirect_to admin_reports_path
    else
      flash[:alert] = "Wystąpił problem. Sprawdź dane formularza."
      render :edit
    end
  end

  private

  def report_params
    begin
      params.require(:report).permit(:title, :description, :photo, :category_id, :latitude, :longitude)
    rescue ActionController::ParameterMissing
      unprocessable_entity
    end
  end

  def find_report
    unless report
      flash[:alert] = "Nie znaleziono takiego zgłoszenia"
      redirect_to admin_reports_path
    end
  end
end
