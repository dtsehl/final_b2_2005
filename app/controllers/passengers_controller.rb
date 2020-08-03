class PassengersController < ApplicationController
  def show
    @passenger = Passenger.find(params[:id])
    @flight_passenger = FlightPassenger.new
  end
end
