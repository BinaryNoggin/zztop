class RemovesCheckinAndCheckoutDatesFromStays < ActiveRecord::Migration[5.0]
  def change
    remove_column :stays, :check_in_date
    remove_column :stays, :check_out_date
  end
end
