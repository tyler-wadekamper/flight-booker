# Flight tracking API provided by The OpenSky Network, https://opensky-network.org

require 'open-uri'
require 'json'

class FlightsController < ApplicationController
  def index
    @flights = search_flights
    @search_params = search_params
    @airport_options = Airport.all.map do |airport|
      [airport.abbreviation_name_string, airport.id]
    end
  end

  private

  def search_flights
    return helpers.get_flights_through_api(search_params) unless params[:departure_airport].nil?

    nil
  end

  def search_params
    params.permit(:departure_airport, :arrival_airport, :date, :num_passengers, :commit)
  end
end
