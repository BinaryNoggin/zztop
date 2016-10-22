class AddSexAndVetStatusToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :sex, :string
    add_column :users, :vet_status, :boolean
  end
end
