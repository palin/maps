class V1::AbusesController < V1::BaseController

  before_filter :abuse_params, only: [:create]

  expose(:report) { Report.find(params[:report_id]) }
  expose(:abuse) { report.abuses.create(abuse_params) }

  def create
    respond_with abuse
  end

  private

  def abuse_params
    begin
      params.require(:abuse).permit(:name)
    rescue ActionController::ParameterMissing
      unprocessable_entity
    end
  end
end
