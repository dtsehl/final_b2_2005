require 'rails_helper'

RSpec.describe Airline do
  describe 'relationships' do
    it {should have_many :flights}
  end

  describe 'Validations' do
    it {should validate_presence_of :name}
  end
end
