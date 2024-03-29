require 'csv'

current_path = File.dirname(__FILE__)
file_path = File.join(current_path, 'airports.csv')

CSV.foreach(file_path, headers: true) do |row|
  identifier = row.field('ident')
  abbreviation = row.field('iata_code')
  name = row.field('name')
  utc_offset = row.field('utc_offset')

  Airport.create(identifier: identifier,
                 abbreviation: abbreviation,
                 name: name,
                 utc_offset: utc_offset)
end