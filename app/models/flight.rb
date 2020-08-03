class Flight < ApplicationRecord
  belongs_to :airline
  has_many :flight_passengers
  has_many :passengers, through: :flight_passengers

  validates_presence_of :date, :time, :departure_city, :arrival_city
  validates_presence_of :number, uniqueness: true

  def number_of_minors
    self.passengers.where("age < ?", 18).count
  end

  def number_of_adults
    self.passengers.where("age >= ?", 18).count
  end
end
