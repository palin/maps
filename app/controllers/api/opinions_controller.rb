# -*- encoding : utf-8 -*-
class Api::OpinionsController < Api::ApiController

  def add
    @opinion.build_from_params(params[:opinion])
  end

  def all
    @report = Report.find_by_id(params[:report_id])
    opinions = OpinionDecorator.decorate(@report.opinions)

    render_json :opinions => opinions
  end

  def rate_up
    @opinion.increment!(:positives)
    set_cookie
    render_json :rating => @opinion.rating
  end

  def rate_down
    @opinion.increment!(:negatives)
    set_cookie
    render_json :rating => @opinion.rating
  end

end