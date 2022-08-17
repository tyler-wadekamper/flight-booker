class CreateFlights < ActiveRecord::Migration[7.0]
  def change
    create_table :flights do |t|
      t.datetime :taking_off
      t.datetime :landing
      t.string :duration
      t.references :departure_airport
      t.references :arrival_airport

      t.timestamps
    end
  end
end
