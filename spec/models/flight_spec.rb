require 'rails_helper'

RSpec.describe Flight do
  describe 'relationships' do
    it {should belong_to :airline}
    it {should have_many :flight_passengers}
    it {should have_many(:passengers).through(:flight_passengers) }
  end

  describe 'Validations' do
    it {should validate_presence_of :number}
    it {should validate_presence_of :date}
    it {should validate_presence_of :time}
    it {should validate_presence_of :departure_city}
    it {should validate_presence_of :arrival_city}
  end

  describe "Instance Methods" do
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

    it ".number_of_minors" do
      expect(@flight_1.number_of_minors).to eq(2)
    end

    it ".number_of_adults" do
      expect(@flight_1.number_of_adults).to eq(2)
    end
  end
end
