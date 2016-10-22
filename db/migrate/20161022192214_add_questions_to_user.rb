class AddQuestionsToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :fleeing, :boolean
    add_column :users, :incarcerated, :boolean
    add_column :users, :welfare, :boolean 
    add_column :users, :insufficent_income, :boolean 
    add_column :users, :alcohol_or_drug_abuse, :boolean
    add_column :users, :physical_health_issue, :boolean
    add_column :users, :mental_health_issue, :boolean 
    add_column :users, :exchange_for_sex, :boolean
  end
end
