class CreateFlights < ActiveRecord::Migration[7.0]
  def change
    create_table :flights do |t|
      t.bigint :taking_off
      t.references :departure_airport
      t.references :arrival_airport

      t.timestamps
    end
  end
end
