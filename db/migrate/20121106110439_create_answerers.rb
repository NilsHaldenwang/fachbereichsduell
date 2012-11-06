class CreateAnswerers < ActiveRecord::Migration
  def change
    create_table :answerers do |t|
      t.string :ip
      t.references :question

      t.timestamps
    end
    add_index :answerers, :question_id
  end
end
