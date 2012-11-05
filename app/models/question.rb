class Question < ActiveRecord::Base
  attr_accessible :number, :question_type, :text

  has_many :text_answers
  has_many :estimation_answers
end
