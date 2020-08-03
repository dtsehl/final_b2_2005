class FlightPassengersController < ApplicationController
  def create
    flight = Flight.where("number = ?", params[:flight_passenger][:flight_number]).first
    FlightPassenger.create(flight_id: flight.id, flight_number: flight_passenger_params[:flight_number], passenger_id: flight_passenger_params[:passenger_id])
    redirect_to request.referrer
  end

  private

  def flight_passenger_params
    params.require(:flight_passenger).permit(:flight_number, :passenger_id)
  end
end
