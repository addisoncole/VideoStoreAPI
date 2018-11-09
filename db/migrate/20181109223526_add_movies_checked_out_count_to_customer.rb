class AddMoviesCheckedOutCountToCustomer < ActiveRecord::Migration[5.2]
  def up
    add_column :customers, :movies_checked_out_count, :integer, default: 0
    Customer.reset_column_information
    Customer.all.each do |w|
      Customer.update_counters w.id, movies_checked_out_count: w.rentals.length
    end
  end
  def down
    remove_column :customer, :movies_checked_out_count
  end
end
