class AddPresidentPointsToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :answer_luecke, :float
    add_column :questions, :answer_rollinger, :float
  end
end
