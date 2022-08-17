# Flight tracking API provided by The OpenSky Network, https://opensky-network.org

class FlightsController < ApplicationController
  def index
    # @flights = find_flights(search_params)
    @airport_options = Airport.all.map do |airport|
      puts airport.name
      [airport.abbreviation_name_string, airport.id]
    end
  end

  private

  # def find_flights(search_params)
    
    
  #   Flight.new()
  # end

  # def search_params
  #   params.require(:flight).permit(:departure_airport, :arrival_airport, :date)
  # end
end
