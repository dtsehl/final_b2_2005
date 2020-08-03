require 'rails_helper'

RSpec.describe 'Passengers Show Page' do
  describe 'As a Visitor' do
    before :each do
      @frontier = Airline.create!(name: 'Frontier Airlines')
      @flight_1 = @frontier.flights.create!(number: "1234", date: "08/01/2020", time: "10:40", departure_city: "Denver", arrival_city: "Las Vegas")
      @flight_2 = @frontier.flights.create!(number: "2345", date: "08/02/2020", time: "10:40", departure_city: "Denver", arrival_city: "Las Vegas")
      @sally = Passenger.create!(name: "Sally", age: 28)
      FlightPassenger.create!(flight_id: @flight_1.id, passenger_id: @sally.id)
      FlightPassenger.create!(flight_id: @flight_2.id, passenger_id: @sally.id)
    end

    it "I can see the passengers details" do
      visit "/passengers/#{@sally.id}"

      expect(page).to have_content(@sally.name)

      within ".flights" do
        expect(page).to have_link(@flight_1.number)
        expect(page).to have_link(@flight_2.number)
      end
    end
  end
end
