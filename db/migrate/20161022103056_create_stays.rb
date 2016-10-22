class CreateStays < ActiveRecord::Migration[5.0]
  def change
    create_table :stays do |t|
      t.references :user, foreign_key: true
      t.references :shelter, foreign_key: true
      t.date :check_in_date
      t.date :check_out_date

      t.timestamps
    end
  end
end
