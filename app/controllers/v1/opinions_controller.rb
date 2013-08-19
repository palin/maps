# -*- encoding : utf-8 -*-
class V1::OpinionsController < V1::ApiController

  before_filter :find_opinion_by_id, only: [:rate_up, :rate_down, :rating, :can_vote]
  before_filter :cookie_enabled?, only: [:rate_up, :rate_down]

  def add
    opinion = Opinion.build_from_params(params)

    if opinion && opinion.save
      render_json new_opinion: OpinionDecorator.decorate(opinion)
    else
      render_error
    end
  end

  def all
    @report = Report.find_by_id(params[:report_id])

    opinions = OpinionDecorator.decorate(@report.opinions.order("created_at DESC"))

    respond_with opinions
  end

  def rating
    render_json rating: @opinion.rating
  end

  { rate_up: :positives, rate_down: :negatives }.each do |key, value|
    define_method(key) do
      @opinion.increment!(value) unless has_cookie?('opinion', @opinion.id)
      set_cookie('opinion', @opinion.id)

      render_json rating: OpinionDecorator.decorate(@opinion)
    end
  end

  private

  def find_opinion_by_id
    @opinion = Opinion.find_by_id(params[:id])
  end
end