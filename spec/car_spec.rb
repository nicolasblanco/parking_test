require 'car'

RSpec.describe Car do
  describe '#initialize' do
    it 'initializes with color and plate_number parameters' do
      car = Car.new(color: 'White', plate_number: 'HE-111-AA')

      expect(car.color).to eq('White')
      expect(car.plate_number).to eq('HE-111-AA')
    end
  end
end
