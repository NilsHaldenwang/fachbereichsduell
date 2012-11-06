class CreateGameStates < ActiveRecord::Migration
  def change
    create_table :game_states do |t|
      t.string :state
      t.integer :team_1_points
      t.integer :team_2_points
      t.integer :team_1_x
      t.integer :team_2_x

      t.timestamps
    end
  end
end
