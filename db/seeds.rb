# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'csv'

current_path = File.dirname(__FILE__)
file_path = File.join(current_path, 'airports.csv')

CSV.foreach(file_path, headers: true) do |row|
  identifier = row.field('ident')
  abbreviation = row.field('iata_code')
  name = row.field('name')

  Airport.create(identifier: identifier,
                 abbreviation: abbreviation,
                 name: name)
end