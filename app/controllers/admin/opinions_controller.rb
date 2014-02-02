# -*- encoding : utf-8 -*-
class Admin::OpinionsController < Admin::AdminController

  expose(:opinions) { Opinion.order(sort_column("Opinion") + " " + sort_direction).page(params[:page]).per(10) }
  expose(:opinion)

  rescue_from ActiveRecord::RecordNotFound, with: :no_record_handler

  def destroy
    if opinion.destroy
      flash[:notice] = "Opinia została usunięta!"
    else
      flash.now[:alert] = "Nie można usunąć opinii!"
    end

    redirect_to admin_opinions_path
  end

  private

  def no_record_handler
    flash[:alert] = "Nie znaleziono takiej opinii"
    redirect_to admin_opinions_path
  end
end
