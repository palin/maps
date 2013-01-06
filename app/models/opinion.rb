class Opinion < ActiveRecord::Base
  attr_accessible :title, :description, :report_id, :negatives, :positives

  belongs_to :report

  validates_presence_of :title, :description

  OPINION_ATTRS = [:title, :description, :report_id]

  def self.build_from_params(params)
    data = {}

    OPINION_ATTRS.each do |att|
      data[att] = params[att]
    end

    Opinion.new(data)
  end

  def rating
    positives - negatives
  end
end
