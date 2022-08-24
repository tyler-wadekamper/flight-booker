require 'securerandom'

class Booking < ApplicationRecord
  validates :confirmation_code, presence: true, uniqueness: true
  belongs_to :flight
  belongs_to :passenger

  private

  def generate_confirmation_code
    SecureRandom.hex(6).upcase
  end
end
