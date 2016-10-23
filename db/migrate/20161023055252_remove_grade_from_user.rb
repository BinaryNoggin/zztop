class RemoveGradeFromUser < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :grade
  end
end
