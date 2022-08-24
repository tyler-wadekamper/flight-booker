class Flight < ApplicationRecord
  validates_uniqueness_of :taking_off, scope: [:arrival_airport_id, :departure_airport_id]

  belongs_to :departure_airport, class_name: 'Airport'
  belongs_to :arrival_airport, class_name: 'Airport'
end
