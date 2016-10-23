class AddGradeToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :grade, :decimal, precision: 8, scale: 5
  end
end
