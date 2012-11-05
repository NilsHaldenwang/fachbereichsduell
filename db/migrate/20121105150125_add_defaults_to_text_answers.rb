class AddDefaultsToTextAnswers < ActiveRecord::Migration
  def change
    change_column_default(:text_answers, :state, TextAnswer::STATE_HIDDEN)
    change_column_default(:text_answers, :count, 0)
  end
end
