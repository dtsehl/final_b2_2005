require 'rails_helper'

RSpec.describe 'Flights Show Page' do
  describe 'As a Visitor' do
    before :each do
      @frontier = Airline.create!(name: 'Frontier Airlines')
      @flight_1 = @frontier.flights.create!(number: "1234", date: "08/01/2020", time: "10:40", departure_city: "Denver", arrival_city: "Las Vegas")
      @harry = Passenger.create!(name: "Harry", age: 30)
      @sally = Passenger.create!(name: "Sally", age: 28)
      @billy = Passenger.create!(name: "Harry", age: 8)
      @molly = Passenger.create!(name: "Sally", age: 10)
      FlightPassenger.create!(flight_id: @flight_1.id, passenger_id: @harry.id, flight_number: @flight_1.number)
      FlightPassenger.create!(flight_id: @flight_1.id, passenger_id: @sally.id, flight_number: @flight_1.number)
      FlightPassenger.create!(flight_id: @flight_1.id, passenger_id: @billy.id, flight_number: @flight_1.number)
      FlightPassenger.create!(flight_id: @flight_1.id, passenger_id: @molly.id, flight_number: @flight_1.number)
    end

    it "I can see the flights details" do
      visit flight_path(@flight_1)

      expect(page).to have_content(@flight_1.number)
      expect(page).to have_content(@flight_1.date)
      expect(page).to have_content(@flight_1.time)
      expect(page).to have_content(@flight_1.departure_city)
      expect(page).to have_content(@flight_1.arrival_city)
      expect(page).to have_content(@frontier.name)
      within ".passengers" do
        expect(page).to have_content(@harry.name)
        expect(page).to have_content(@sally.name)
        expect(page).to have_content(@billy.name)
        expect(page).to have_content(@molly.name)
      end
    end

    it "I can see the count of minors and adults on the flight" do
      visit flight_path(@flight_1)

      within ".passengers" do
        expect(page).to have_content("Number of minors on this flight: #{@flight_1.number_of_minors}")
        expect(page).to have_content("Number of minors on this flight: 2")
        expect(page).to have_content("Number of adults on this flight: #{@flight_1.number_of_adults}")
        expect(page).to have_content("Number of adults on this flight: 2")
      end
    end
  end
end
