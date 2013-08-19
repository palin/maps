# -*- encoding : utf-8 -*-
class V1::ReportsController < V1::ApiController

  before_filter :find_report, only: [:show, :update]
  before_filter :cookie_enabled?, only: [:rate_up, :rate_down]

  def send_report
    if params[:report].present?
      @report = Report.build_from_params(params[:report])
    end

    if @report
      if @report.save
        response = 200
      else
        response = 400
      end
    else
      response = 403
    end

    respond_to do |format|
      format.json { render_json response }
      format.html { redirect_to root_path }
    end
  end

  def show
    @disabled_opinions = disabled_opinions
    @can_vote = !has_cookie?('report', @report.id)

    respond_with @report
  end

  def index
    @reports = Report.all

    respond_with @reports
  end

  def update
    unless has_cookie?('report', @report.id)
      if params[:positives].present? && params[:positives] != @report.positives
        @report.increment!(:positives)
      elsif params[:negatives].present? && params[:negatives] != @report.negatives
        @report.increment!(:negatives)
      end
      set_cookie('report', @report.id)

      respond_with @report
    else
      not_found
    end
  end

  private

  def find_report
    render_error 404, reason: "Nie znaleziono takiego zgłoszenia!" unless @report = Report.find_by_id(params[:report_id]) || Report.find_by_id(params[:id])
  end

  def disabled_opinions
    disable_voting = []

    @report.opinions.each do |opinion|
      disable_voting.push opinion.id if has_cookie?('opinion', opinion.id)
    end
    disable_voting
  end
end
