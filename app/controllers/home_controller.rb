# -*- encoding : utf-8 -*-
class HomeController < ApplicationController
  def index
    @report = Report.new
    @categories = Category.all
  end
end
