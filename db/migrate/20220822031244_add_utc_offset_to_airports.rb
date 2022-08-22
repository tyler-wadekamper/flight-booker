class AddUtcOffsetToAirports < ActiveRecord::Migration[7.0]
  def change
    add_column :airports, :utc_offset, :string
  end
end
