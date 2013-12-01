# -*- encoding : utf-8 -*-
class Abuse < ActiveRecord::Base

  belongs_to :report

  validates_presence_of :name, :report_id

  def reason
    case name
    when "spam"
      "Spam"
    when "duplicate"
      "Duplikat"
    when "content"
      "Nieodpowiednia treść"
    when "solved"
      "Problem rozwiązano"
    else
      "Brak powodu"
    end
  end
end
