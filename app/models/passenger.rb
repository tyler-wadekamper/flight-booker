class Passenger < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates :full_name, presence: true, uniqueness: true

  belongs_to :booking
end
