class BookingsController < ApplicationController
  def new
    @submit_params = submit_params
  end

  private

  def submit_params
    params.permit(:num_passengers, :flight_id, :commit)
  end
end
