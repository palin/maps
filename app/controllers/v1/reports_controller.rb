class V1::ReportsController < V1::BaseController

  before_filter :report_params, only: [:create, :update]

  expose(:report) { Report.find_by_id(params[:id]) || Report.new(report_params) }
  expose(:reports) { Report.all }
  expose(:user_can_vote?) { !has_cookie?('report', report.id) }

  before_filter :cookie_enabled?, only: [:update]

  def index
  end

  def show
    respond_with report
  end

  def create
    report.save
    respond_to do |format|
      format.json { respond_with report }
      format.html { redirect_to root_path }
    end
  end

  def update
    if has_cookie?('report', report.id)
      forbidden_request
    else
      report.rate!(report_params[:key])
      set_cookie('report', report.id)

      respond_with report
    end
  end

  private

  def report_params
    begin
      params.require(:report).permit(:id, :key, :title, :description, :photo, :category_id, :latitude, :longitude)
    rescue ActionController::ParameterMissing
      unprocessable_entity
    end
  end
end
