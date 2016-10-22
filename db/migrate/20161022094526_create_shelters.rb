class CreateShelters < ActiveRecord::Migration[5.0]
  def change
    create_table :shelters do |t|
      t.string :name
      t.string :address
      t.string :description
      t.string :type

      t.timestamps
    end
  end
end
