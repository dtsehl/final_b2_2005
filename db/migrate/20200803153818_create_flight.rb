class CreateFlight < ActiveRecord::Migration[5.1]
  def change
    create_table :flights do |t|
      t.string :number
      t.date :date
      t.time :time
      t.string :departure_city
      t.string :arrival_city
      t.references :airline, foreign_key: true

      t.timestamps
    end
  end
end
