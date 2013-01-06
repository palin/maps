# -*- encoding : utf-8 -*-
class Admin::OpinionsController < ApplicationController

  before_filter :find_opinion_by_id

  def edit
  end

  def destroy
  end

  def show
  end

  private

  def find_opinion_by_id
    @opinion = Opinion.find_by_id(params[:id])
    redirect_back :alert => "Nie ma takiej opinii" unless @opinion
  end
end
