# -*- encoding : utf-8 -*-
class Abuse < ActiveRecord::Base
  attr_accessible :name, :report_id

  belongs_to :report

  validates_presence_of :name, :report_id

end
