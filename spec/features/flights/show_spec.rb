require 'rails_helper'

RSpec.describe 'Flights Show Page' do
  describe 'As a Visitor' do
    before :each do
      @frontier = Airline.create!(name: 'Frontier Airlines')
      @flight_1 = @frontier.flights.create!(number: "1234", date: "08/01/2020", time: "10:40", departure_city: "Denver", arrival_city: "Las Vegas")
      @harry = Passenger.create!(name: "Harry", age: 30)
      @sally = Passenger.create!(name: "Sally", age: 28)
      FlightPassenger.create!(flight_id: @flight_1.id, passenger_id: @harry.id)
      FlightPassenger.create!(flight_id: @flight_1.id, passenger_id: @sally.id)
    end

    it "I can see the flights details" do
      visit "/flights/#{@flight_1.id}"

      expect(page).to have_content(@flight_1.number)
      expect(page).to have_content(@flight_1.date)
      expect(page).to have_content(@flight_1.time)
      expect(page).to have_content(@flight_1.departure_city)
      expect(page).to have_content(@flight_1.arrival_city)
      expect(page).to have_content(@frontier.name)
      within ".passengers" do
        expect(page).to have_content(@harry.name)
        expect(page).to have_content(@sally.name)
      end
    end
  end
end
