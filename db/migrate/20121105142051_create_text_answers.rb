class CreateTextAnswers < ActiveRecord::Migration
  def change
    create_table :text_answers do |t|
      t.string :content
      t.string :state
      t.integer :count
      t.references :question

      t.timestamps
    end
  end
end
