class V2::OpinionsController < V2::BaseController

  before_filter :opinion_params, only: [:create, :update]
  expose(:report) { Report.find(params[:report_id]) }
  expose(:opinion) { report.opinions.where(id: params[:id]).first || report.opinions.create(opinion_params) }
  expose(:opinions) { report.opinions.order("created_at DESC") }

  before_filter :cookie_enabled?, only: [:update]

  def index
    respond_with opinions
  end

  def show
    respond_with opinion
  end

  def create
    respond_with opinion
  end

  def update
    if has_cookie?('opinion', opinion.id)
      forbidden_request
    else
      opinion.rate!(opinion_params[:key])
      set_cookie('opinion', opinion.id)

      respond_with opinion
    end
  end

  private

  def opinion_params
    begin
      params.require(:opinion).permit(:id, :key, :title, :description, :positives, :negatives)
    rescue ActionController::ParameterMissing
      unprocessable_entity
    end
  end
end
