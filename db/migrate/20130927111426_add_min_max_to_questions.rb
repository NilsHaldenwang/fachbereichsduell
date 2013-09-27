class AddMinMaxToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :min, :integer
    add_column :questions, :max, :integer
  end
end
