class PassengerMailer < ApplicationMailer
  default from: 'booking@flightbooker.com'

  def confirmation_email
    @booking = params[:booking]
    @passenger = params[:passenger]

    mail(to: @passenger.email, subject: "Your flight to #{@booking.flight.arrival_airport.name}")
  end
end
