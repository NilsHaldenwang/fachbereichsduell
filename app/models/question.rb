class Question < ActiveRecord::Base
  attr_accessible :number, :question_type, :text

  has_many :text_answers
  has_many :estimation_answers

  define_constants_for_attribute(:question_type, :estimation, :choices)
end
