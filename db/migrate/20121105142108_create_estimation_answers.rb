class CreateEstimationAnswers < ActiveRecord::Migration
  def change
    create_table :estimation_answers do |t|
      t.float :value
      t.references :question

      t.timestamps
    end
  end
end
