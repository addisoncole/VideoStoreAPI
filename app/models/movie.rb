class Movie < ApplicationRecord
  validates :title, presence: true
  validates :inventory, presence: true

  has_many :rentals, dependent: :nullify

  def get_available_number
    inventory = self.inventory
    rentals = self.rentals.where(:checked_out? => true)
    return inventory - rentals.length
  end

end
