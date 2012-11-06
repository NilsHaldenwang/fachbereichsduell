class AddAnsweredByTeamToTextAnswers < ActiveRecord::Migration
  def change
    add_column :text_answers, :answered_by_team, :integer
  end
end
