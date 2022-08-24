class Passenger < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates :full_name, presence: true, uniqueness: true

  has_many :bookings
end
