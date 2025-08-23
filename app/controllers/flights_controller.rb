class FlightsController < ApplicationController
  def index
    @airports = Airport.all
    @dates = Flight.order(:departure_time).pluck(:departure_time).map(&:to_date).uniq


    @flights = Flight.all
    if params[:from].present? && params[:to].present? && params[:date].present?
      @flights = @flights.where(
        departure_airport_id: params[:from],
        arrival_airport_id: params[:to]
      ).where(departure_time: Date.parse(params[:date]).all_day)
    end
  end
end