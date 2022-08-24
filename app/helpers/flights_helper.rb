module FlightsHelper
  def get_flights_through_api(search_params)
    arrival_airport = airport_by_id(search_params[:arrival_airport])
    departure_airport = airport_by_id(search_params[:departure_airport])
    total_url = build_open_sky_url(departure_airport, params[:date])

    begin
      api_response = URI.parse(total_url).open(&:readline)
    rescue
      return []
    else
      flights_json = JSON.parse(api_response)
      create_flights(flights_json, arrival_airport, departure_airport)
      departure_airport.departing_flights.order(taking_off: :asc)
    end
  end

  def airport_by_id(airport_id)
    Airport.find(airport_id)
  end

  def build_open_sky_url(departure_airport, date_param)
    date_with_departure_timezone = date_param + ' ' + departure_airport.utc_offset
    time_start_epoch = Time.strptime(date_with_departure_timezone, "%Y-%m-%d %z").to_i
    time_end_epoch = time_start_epoch + (23 * 60 * 60 + 59 * 60)

    base_url = 'https://opensky-network.org/api/flights/departure?'
    identifier_parameter = 'airport=' + departure_airport.identifier + '&'
    begin_parameter = 'begin=' + time_start_epoch.to_s + '&'
    end_parameter = 'end=' + time_end_epoch.to_s

    total_url = base_url + identifier_parameter + begin_parameter + end_parameter
    puts total_url
    total_url
  end

  def create_flights(flights_json, arrival_airport, departure_airport)
    flights_json.each do |flight|
      next unless flight['estArrivalAirport'] == arrival_airport.identifier

      taking_off_epoch = flight['firstSeen']
      departure_airport.departing_flights.create(taking_off: taking_off_epoch,
                                                 arrival_airport_id: arrival_airport.id)
    end
  end
end
