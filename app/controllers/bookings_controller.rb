class BookingsController < ApplicationController
  def new
    @flight = Flight.find(params[:flight_id])
    @booking = Booking.new(flight: @flight)
    @passengers_count = params[:passengers].to_i
    @passengers_count.times { @booking.passengers.build }
  end

  def create
    @booking = Booking.new(booking_params)
    if @booking.save
      PassengerMailer.confirmation_email(@passenger).deliver_later
      redirect_to @booking, notice: "Booking successfully created!"
    else
      @flight = @booking.flight
      @passengers_count = @booking.passengers.size
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @booking = Booking.find(params[:id])
  end

  private

  def booking_params
    params.require(:booking).permit(:flight_id, passengers_attributes: [:name, :email])
  end
end
