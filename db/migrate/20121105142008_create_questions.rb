class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.integer :number
      t.string :text
      t.string :question_type

      t.timestamps
    end
  end
end
