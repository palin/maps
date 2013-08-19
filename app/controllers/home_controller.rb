# -*- encoding : utf-8 -*-
class HomeController < ApplicationController

  def index
    @report = Report.new
    @categories = Category.all.sort_by(&:created_at)
  end
end
