class Answerer < ActiveRecord::Base
  attr_accessible :ip

  belongs_to :question
end
