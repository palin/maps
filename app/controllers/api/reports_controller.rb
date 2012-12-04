# -*- encoding : utf-8 -*-
class Api::ReportsController < Api::ApiController

  def send_report
    if params[:report].present?
      p = params[:report]
      response = {:success => true, :message => "Poprawnie utworzono zgłoszenie!"}
    else
      response = {:success => false, :message => "Nie udało się przesłać zgłoszenia!"}
    end

    respond_to do |format|
      format.json { render :json => response}
    end
  end
end
