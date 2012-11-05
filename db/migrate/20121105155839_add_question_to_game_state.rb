class AddQuestionToGameState < ActiveRecord::Migration
  def change
    add_column :game_states, :question_number, :integer
    add_index :questions, :number, unique: true
  end
end
