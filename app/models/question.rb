class Question < ActiveRecord::Base
  attr_accessible :number, :question_type, :text, :answer_luecke, :answer_rollinger, :rounding_factor, :min, :max

  has_many :text_answers
  has_many :estimation_answers

  has_many :answerers

  define_constants_for_attribute(:question_type, :estimation, :choices)

  def was_answered_by?(ip)
    answerers.where(ip: ip).first
  end

  def was_answered_by!(ip)
    if ip =~ Resolv::IPv4::Regex
      answerers.create({ip: ip})
    end
  end

  def answerer_count
    if choices?
      text_answers.inject(0) { |sum, a| sum += a.count }
    elsif estimation?
      estimation_answers.count
    end
  end

  def average_estimation
    estimation_answers.average(:value) || 0
  end
end
