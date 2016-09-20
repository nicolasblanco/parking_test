require 'parking'
require 'car'

RSpec.describe Parking do
  let(:parking) { Parking.new(capacity: 6) }
  let(:car) { Car.new(color: 'White', plate_number: 'KE-AAA-POUET') }

  describe '#initialize' do
    it 'initializes with capacity parameter' do
      parking = Parking.new(capacity: 4)

      expect(parking.capacity).to eq(4)
      expect(parking.slots).to be_empty
    end
  end

  describe '#delete_at' do
    it 'removes the car on the given slot' do
      parking << car
      parking.delete_at(1)
      expect(parking.slots[0]).to be_nil
    end
  end

  describe '#slots_hash' do
    it 'returns a hash' do
      parking << car
      parking << Car.new(color: 'Black', plate_number: 'KE-AAA-POUET')

      hash = parking.slots_hash
      expect(hash).to be_a(Hash)
      expect(hash.keys).to eq(['1', '2'])
    end
  end

  describe '#<<' do
    context 'when at least a slot is available' do
      context 'when the available slot is at the end' do
        it 'returns the slot number of the newly inserted car' do
          expect(parking << car).to eq(1)
        end
      end

      context 'when the available slot is the first available' do
        it 'returns the slot number of the newly inserted car' do
          parking << car
          parking << car
          parking << car
          parking.delete_at(2)

          expect(parking << car).to eq(2)
        end
      end
    end

    context 'when no more slots is available' do
      let(:parking) { Parking.new(capacity: 1) }

      it 'raises an exception' do
        parking << car
        expect { parking << car }.to raise_error(Parking::NoSlotsAvailable)
      end
    end
  end
end
