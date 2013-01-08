# -*- encoding : utf-8 -*-
class Admin::OpinionsController < Admin::AdminController

  before_filter :require_admin
  before_filter :find_opinion, :except => [:index]

  def index
    @opinions = Opinion.order(sort_column("Opinion") + " " + sort_direction).page(params[:page]).per(10)
  end

  def destroy
    if @opinion.destroy
      flash[:notice] = "Opinia została usunięta!"
    else
      flash.now[:alert] = "Nie można usunąć opinii!"
    end

    redirect_to admin_opinions_path and return
  end

  private

  def find_opinion
    @opinion = Opinion.find_by_id(params[:id])
    unless @opinion
      flash[:alert] = "Nie znaleziono takiej opinii"
      redirect_to admin_opinions_path and return
    end
  end
end
