class BookingsController < ApplicationController
  def new
    @booking = Booking.new
    @flight = Flight.find(submit_params[:flight_id])
    @num_passengers = submit_params[:num_passengers].to_i
    @num_passengers.times { @booking.passengers.build }
  end

  def create
    @booking = Booking.create(create_params.merge(confirmation_code: Booking.generate_confirmation_code))

    @booking.passengers.each do |passenger|
      PassengerMailer.with(booking: @booking, passenger:).confirmation_email.deliver_later
    end

    redirect_to booking_path(@booking.id)
  end

  def show
    @booking = Booking.find(show_params[:id])
  end

  private

  def submit_params
    params.permit(:num_passengers, :flight_id, :commit)
  end

  def show_params
    params.permit(:id, :commit)
  end

  def create_params
    params.require(:booking).permit(:id, :flight_id, :commit, passengers_attributes: %i[id email full_name])
  end
end
