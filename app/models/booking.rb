require 'securerandom'

class Booking < ApplicationRecord
  validates :confirmation_code, presence: true, uniqueness: true
  belongs_to :flight
  has_many :passengers

  accepts_nested_attributes_for :passengers

  def self.generate_confirmation_code
    SecureRandom.hex(3).upcase
  end
end
