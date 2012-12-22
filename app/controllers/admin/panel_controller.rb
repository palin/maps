# -*- encoding : utf-8 -*-
class Admin::PanelController < Admin::AdminController

  before_filter :require_admin, :only => [:index]

  def index
  end
end
