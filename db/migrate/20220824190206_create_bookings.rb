class CreateBookings < ActiveRecord::Migration[7.0]
  def change
    create_table :bookings do |t|
      t.string :confirmation_code
      t.references :flight

      t.timestamps
    end
  end
end
