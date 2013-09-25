class AddRoundingFactorToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :rounding_factor, :integer
  end
end
