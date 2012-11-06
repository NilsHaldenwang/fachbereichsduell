class EstimationAnswer < ActiveRecord::Base
  attr_accessible :value

  belongs_to :question
end
