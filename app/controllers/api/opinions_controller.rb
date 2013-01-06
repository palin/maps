# -*- encoding : utf-8 -*-
class Api::OpinionsController < Api::ApiController

  before_filter :find_opinion_by_id, :only => [:rate_up, :rate_down, :rating, :can_vote]
  before_filter :cookie_enabled?, :only => [:rate_up, :rate_down]

  def add
    opinion = Opinion.build_from_params(params)

    if opinion && opinion.save
      render_json :new_opinion => OpinionDecorator.decorate(opinion)
    else
      render_error
    end
  end

  def all
    @report = Report.find_by_id(params[:report_id])
    opinions = OpinionDecorator.decorate(@report.opinions.order("created_at DESC"))

    render_json :opinions => opinions
  end

  def rate_up
    @opinion.increment!(:positives) unless has_cookie?('opinion', @opinion.id)
    set_cookie('opinion', @opinion.id)

    render_json :rating => OpinionDecorator.decorate(@opinion)
  end

  def rate_down
    @opinion.increment!(:negatives) unless has_cookie?('opinion', @opinion.id)
    set_cookie('opinion', @opinion.id)

    render_json :rating => OpinionDecorator.decorate(@opinion)
  end

  def rating
    render_json :rating => @opinion.rating
  end

  def can_vote
    @report = Report.find_by_id(params[:report_id])
    opinions = []

    @report.opinions.each do |opinion|
      opinions.push opinion.id if has_cookie?('opinion', opinion.id)
    end

    render_json :opinions => opinions
  end

  private

  def find_opinion_by_id
    @opinion = Opinion.find_by_id(params[:id])
  end
end