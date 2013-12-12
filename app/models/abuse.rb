# -*- encoding : utf-8 -*-
class Abuse < ActiveRecord::Base

  belongs_to :report

  validates_presence_of :name, :report_id

  def reason
    I18n.t("models.abuse.#{name}")
  end
end
