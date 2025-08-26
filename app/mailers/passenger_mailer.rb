class PassengerMailer < ApplicationMailer
  default from: 'no-reply@twojadomena.com'

  def confirmation_email(passenger)
    @passenger = passenger
    @flight = passenger.booking.flight
    mail(to: @passenger.email, subject: 'Potwierdzenie rezerwacji lotu')
  end
end
