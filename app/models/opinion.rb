class Opinion < ActiveRecord::Base
  attr_accessible :description, :negatives, :positives, :title

  belongs_to :report
end
