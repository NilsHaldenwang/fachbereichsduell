class TextAnswer < ActiveRecord::Base
  attr_accessible :content, :count, :state

  belongs_to :question

  define_constants_for_attribute(:state, :hidden, :visible)

  def normalized_points
    number_of_answerers = question.answerer_count

    if number_of_answerers > 0
      ( 100 * self.count.to_f / number_of_answerers ).floor
    else
      0
    end
  end
end

