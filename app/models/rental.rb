class Rental < ApplicationRecord
  belongs_to :customer
  belongs_to :movie

  def set_rental_dates
    date = DateTime.now
    self.checkout_date = date
    date += 7
    self.due_date = date
  end
end
