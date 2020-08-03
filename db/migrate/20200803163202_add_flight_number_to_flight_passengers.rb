class AddFlightNumberToFlightPassengers < ActiveRecord::Migration[5.1]
  def change
    add_column :flight_passengers, :flight_number, :string
  end
end
