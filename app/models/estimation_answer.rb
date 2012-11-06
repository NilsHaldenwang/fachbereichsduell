class EstimationAnswer < ActiveRecord::Base
  attr_accessible :value, :question

  belongs_to :question

  #ensure only positive answers
  validates_numericality_of :value, greater_than_or_equal_to: 0

end
