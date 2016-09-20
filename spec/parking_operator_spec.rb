require 'parking_operator'

RSpec.describe ParkingOperator do
  subject { described_class.new }
  before(:each) do
    subject.create_parking_lot '3'
    subject.park 'HE-KE-POUET', 'Red'
    subject.park 'HE-KE-HAHA', 'Yellow'
  end

  describe '#create_parking_lot' do
    it 'initializes a parking with the capacity of the given parameter' do
      subject.create_parking_lot '6'

      expect(subject.parking.capacity).to eq(6)
    end
  end

  describe '#park' do
    before(:each) { subject.create_parking_lot '1' }

    it 'parks a new car with the given parameters and returns the slot number' do
      result = subject.park 'HE-KE-POUET', 'Red'

      expect(result).to include('1')
    end

    it 'returns a sorry message if the parking is full' do
      subject.park 'HE-KE-POUET', 'Red'
      result = subject.park 'HE-KE-POUET', 'White'

      expect(result).to include('Sorry')
    end
  end

  describe '#leave' do
    it 'removes a car from the given slot and gives back the slot number' do
      expect(subject.leave('1')).to include('1')
    end
  end

  describe '#registration_numbers_for_cars_with_colour' do
    it 'returns the registration numbers for a given color' do
      expect(subject.registration_numbers_for_cars_with_colour('Red')).to include('HE-KE-POUET')
    end
  end

  describe '#slot_numbers_for_cars_with_colour' do
    it 'returns the slots numbers for a given color' do
      expect(subject.slot_numbers_for_cars_with_colour('Red')).to eq('1')
    end
  end

  describe '#slot_number_for_registration_number' do
    context 'when the car is found' do
      it 'returns the slot number for a given plate number' do
        expect(subject.slot_number_for_registration_number('HE-KE-POUET')).to eq('1')
      end
    end

    context 'when the car is not found' do
      it 'returns a "Not Found" message' do
        expect(subject.slot_number_for_registration_number('HE-KE-OHNOOES')).to eq('Not found')
      end
    end
  end

  describe '#status' do
    it 'returns the data of each slot with a header line' do
      status = subject.status

      expect(status.split("\n").size).to eq(3)
      expect(status).to include('HE-KE-POUET', 'HE-KE-HAHA')
    end
  end

  describe '#execute_command' do
    context 'when the command is invalid' do
      it 'raises an exception' do
        expect { subject.execute_command('foobar 42') }.to raise_error(ParkingOperator::InvalidCommand)
      end
    end

    context 'when the command is valid' do
      it 'sends the command' do
        expect(subject).to receive(:park).with('SHINY-CAR', 'Yellow').once

        subject.execute_command('park SHINY-CAR Yellow')
      end
    end
  end
end
