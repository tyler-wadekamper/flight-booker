class CreateAirports < ActiveRecord::Migration[7.0]
  def change
    create_table :airports do |t|
      t.string :identifier
      t.string :abbreviation
      t.string :name

      t.timestamps
    end
  end
end
