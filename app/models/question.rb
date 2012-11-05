class Question < ActiveRecord::Base
  attr_accessible :number, :question_type, :text

  has_many :text_answers
  has_many :estimation_answers

  TYPE_ESTIMATION = "estimation"
  TYPE_CHOICES = "choices"

  def choices?
    self.question_type == TYPE_CHOICES
  end

  def estimation?
    self.question_type == TYPE_ESTIMATION
  end
end
