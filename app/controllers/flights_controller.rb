# Flight tracking API provided by The OpenSky Network, https://opensky-network.org

require 'open-uri'
require 'json'

class FlightsController < ApplicationController
  def index
    @flights = set_flights

    @airport_options = Airport.all.map do |airport|
      [airport.abbreviation_name_string, airport.id]
    end
  end

  private

  def set_flights
    return find_flights(search_params) unless params[:departure_airport].nil?

    nil
  end

  def find_flights(search_params)
    departure_airport = Airport.find(params[:departure_airport])
    date_with_departure_timezone = params[:date] + ' ' + departure_airport.utc_offset
    time_start_epoch = Time.strptime(date_with_departure_timezone, "%Y-%m-%d %z").to_i
    time_end_epoch = time_start_epoch + (23 * 60 * 60 + 59 * 60)

    base_url = 'https://opensky-network.org/api/flights/departure?'
    identifier_parameter = 'airport=' + departure_airport.identifier + '&'
    begin_parameter = 'begin=' + time_start_epoch.to_s + '&'
    end_parameter = 'end=' + time_end_epoch.to_s

    total_url = base_url + identifier_parameter + begin_parameter + end_parameter
    puts total_url

    file = URI.parse(total_url).open(&:readline)

    flights_json = JSON.parse(file)

    arrival_airport = Airport.find(search_params[:arrival_airport])

    flights_json.each do |flight|
      next unless flight['estArrivalAirport'] == arrival_airport.identifier

      taking_off_epoch = flight['firstSeen']
      departure_airport.departing_flights.create(taking_off: taking_off_epoch,
                                                 arrival_airport_id: arrival_airport.id)
    end
  end

  def search_params
    params.permit(:departure_airport, :arrival_airport, :date, :num_passengers, :commit)
  end
end
