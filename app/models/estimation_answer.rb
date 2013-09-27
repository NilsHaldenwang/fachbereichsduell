class EstimationAnswer < ActiveRecord::Base
  attr_accessible :value, :question

  belongs_to :question

  #ensure only positive answers
  validates_numericality_of :value, greater_than_or_equal_to: 0

  validate :check_interval_range

  protected
  def check_interval_range
    if value < question.min || value > question.max
      errors.add(:base, "Antwort lag nicht im erlaubten Intervall.")
    end
  end
end
