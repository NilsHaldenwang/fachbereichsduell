class Question < ActiveRecord::Base
  attr_accessible :number, :question_type, :text

  has_many :text_answers
  has_many :estimation_answers

  has_many :answerers

  define_constants_for_attribute(:question_type, :estimation, :choices)

  def was_answered_by?(ip)
  	answerers.where(ip: ip).first
  end

  def was_answered_by!(ip)
  	#todo: no validation
  	answerers.create({ip: ip})
  end

end
