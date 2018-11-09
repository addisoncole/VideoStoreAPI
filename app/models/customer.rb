class Customer < ApplicationRecord
  validates :name, presence: true

  has_many :rentals, dependent: :nullify

  def get_number_checked_out
    rentals = self.rentals.where(:checked_out? => true)
    return rentals.count
  end

end
