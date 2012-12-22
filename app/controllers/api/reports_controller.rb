# -*- encoding : utf-8 -*-
class Api::ReportsController < Api::ApiController
  include Draper

  def send_report
    if params[:report].present?
      @report = Report.build_from_params(params[:report])
    end

    if @report.save
      response = {:success => true, :message => "Poprawnie utworzono zgłoszenie!"}
    else
      response = {:success => false, :message => @report.errors}
    end

    respond_to do |format|
      format.json { render :json => response }
      format.html { redirect_to root_path }
    end
  end

  def all
    reports = ReportDecorator.decorate(Report.all)

    render_json :reports => reports
  end
end
