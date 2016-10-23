class CreateHistories < ActiveRecord::Migration[5.0]
  def change
    create_table :histories do |t|
      t.references :user, foreign_key: true
      t.string :zipcode
      t.boolean :needs_shelter
      t.integer :rating
      t.boolean :fleeing
      t.boolean :incarcerated
      t.boolean :welfare
      t.boolean :insufficent_income
      t.boolean :alcohol_or_drug_abuse
      t.boolean :physical_health_issue
      t.boolean :mental_health_issue
      t.boolean :exchange_for_sex

      t.timestamps
    end
  end
end
