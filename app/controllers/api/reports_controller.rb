# -*- encoding : utf-8 -*-
class Api::ReportsController < Api::ApiController
  include Draper
  before_filter :find_report, :only => [:rate_up, :rate_down, :can_vote, :rating]
  before_filter :cookie_enabled?, :only => [:rate_up, :rate_down]

  def send_report
    if params[:report].present?
      @report = Report.build_from_params(params[:report])
    end

    if @report
      if @report.save
        response = {:success => true, :message => "Poprawnie utworzono zgłoszenie!"}
      else
        response = {:success => false, :message => @report.errors}
      end
    else
      response = {:success => false, :message => "Nie można utworzyć zgłoszenia!"}
    end

    respond_to do |format|
      format.json { render :json => response }
      format.html { redirect_to root_path}
    end
  end

  def all
    reports = ReportDecorator.decorate(Report.all)

    render_json :reports => reports
  end

  def rate_up
    @report.increment!(:positives) unless has_cookie?('report', @report.id)
    set_cookie('report', @report.id)
    render_json :rating => @report.rating
  end

  def rate_down
    @report.increment!(:negatives) unless has_cookie?('report', @report.id)
    set_cookie('report', @report.id)
    render_json :rating => @report.rating
  end

  def rating
    render_json :rating => @report.rating
  end

  def can_vote
    if has_cookie?('report', @report.id)
      render_error 409, :reason => "Już głosowałeś na to zgłoszenie!"
    else
      render_json 200
    end
  end

  private

  def find_report
    render_error 409, :reason => "Nie znaleziono takiego zgłoszenia!" unless @report = Report.find_by_id(params[:report]) || Report.find_by_id(params[:id])
  end
end
