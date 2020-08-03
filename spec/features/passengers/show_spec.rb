require 'rails_helper'

RSpec.describe 'Passengers Show Page' do
  describe 'As a Visitor' do
    before :each do
      @frontier = Airline.create!(name: 'Frontier Airlines')
      @flight_1 = @frontier.flights.create!(number: "1234", date: "08/01/2020", time: "10:40", departure_city: "Denver", arrival_city: "Las Vegas")
      @flight_2 = @frontier.flights.create!(number: "2345", date: "08/02/2020", time: "10:40", departure_city: "Denver", arrival_city: "Las Vegas")
      @flight_3 = @frontier.flights.create!(number: "3456", date: "08/03/2020", time: "10:40", departure_city: "Denver", arrival_city: "Las Vegas")
      @sally = Passenger.create!(name: "Sally", age: 28)
      FlightPassenger.create!(flight_id: @flight_1.id, passenger_id: @sally.id, flight_number: @flight_1.number)
      FlightPassenger.create!(flight_id: @flight_2.id, passenger_id: @sally.id, flight_number: @flight_2.number)
    end

    it "I can see the passengers details" do
      visit passenger_path(@sally)

      expect(page).to have_content(@sally.name)

      within ".flights" do
        expect(page).to have_link(@flight_1.number)
        expect(page).to have_link(@flight_2.number)
      end
    end

    it "I can assign a passenger to a flight" do
      visit passenger_path(@sally)

      within ".flights" do
        expect(page).to_not have_link(@flight_3.number)
      end

      fill_in "Flight number", with: @flight_3.number
      click_on "Submit"
      expect(current_path).to eq(passenger_path(@sally))

      within ".flights" do
        expect(page).to have_link(@flight_3.number)
      end
    end
  end
end
