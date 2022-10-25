class CreatePassengers < ActiveRecord::Migration[7.0]
  def change
    create_table :passengers do |t|
      t.string :full_name
      t.string :email
      t.references :booking

      t.timestamps
    end
  end
end
