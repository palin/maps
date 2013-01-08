# -*- encoding : utf-8 -*-
class Admin::ReportsController < Admin::AdminController
  before_filter :require_admin
  before_filter :find_report, :except => [:index]

  def index
    @reports = Report.order(sort_column("Report") + " " + sort_direction).page(params[:page]).per(10)
  end

  def destroy
    if @report.destroy
      flash[:notice] = "Zgłoszenie zostało usunięte!"
    else
      flash.now[:alert] = "Nie można usunąć zgłoszenia!"
    end

    redirect_to admin_reports_path and return
  end

  def edit

  end

  def update
    if params[:report][:category_id].present?
      category = Category.find_by_unique_id(params[:report][:category_id])
      params[:report][:category_id] = category.id
    end

    @report.assign_attributes(params[:report])

    if @report.save
      flash[:notice] = "Zgłoszenie zostało zaktualizowane!"
      redirect_to admin_reports_path and return
    else
      flash[:alert] = "Wystąpił problem. Sprawdź dane formularza."
      render :action => 'edit'
    end
  end

  def find_report
    @report = Report.find_by_id(params[:id])
    unless @report
      flash[:alert] = "Nie znaleziono takiego zgłoszenia"
      redirect_to admin_reports_path and return
    end
  end

end
