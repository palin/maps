# -*- encoding : utf-8 -*-
class HomeController < ApplicationController
  def index
    @report = Report.new
  end
end
