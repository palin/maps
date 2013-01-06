class Opinion < ActiveRecord::Base
  attr_accessible :description, :negatives, :positives, :title

  belongs_to :report

  validates_presence_of :title, :description

  def rating
    positives - negatives
  end
end
