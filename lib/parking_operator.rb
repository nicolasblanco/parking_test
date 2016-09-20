require 'parking'
require 'car'

class ParkingOperator
  attr_accessor :parking
  AVAILABLE_COMMANDS = %w(create_parking_lot park leave registration_numbers_for_cars_with_colour
                          slot_numbers_for_cars_with_colour slot_number_for_registration_number
                          status).freeze

  def create_parking_lot(number)
    @parking = Parking.new(capacity: number.to_i)
    "Created a parking lot with #{number} slots"
  end

  def park(plate_number, color)
    index = @parking << Car.new(plate_number: plate_number, color: color)
    "Allocated slot number: #{index}"
  rescue Parking::NoSlotsAvailable
    'Sorry, parking lot is full'
  end

  def leave(index)
    @parking.delete_at(index.to_i)
    "Slot number #{index} is free"
  end

  def registration_numbers_for_cars_with_colour(color)
    @parking.slots.select { |car| car.color == color }.map(&:plate_number).join(', ')
  end

  def slot_numbers_for_cars_with_colour(color)
    @parking.slots_hash.select { |_, car| car.color == color }.keys.join(', ')
  end

  def slot_number_for_registration_number(plate_number)
    index = @parking.slots_hash.find { |_, car| car.plate_number == plate_number }&.first
    index ? index : 'Not found'
  end

  def status
    ["Slot\tRegistration No\tColour"].tap do |res|
      @parking.slots.each_with_index do |car, index|
        res << (car ? "#{index + 1}\t#{car.plate_number}\t#{car.color}" : "#{index + 1}\tAvailable")
      end
    end.join("\n")
  end

  def execute_command(command_string)
    cmd = command_string.split(' ').first
    args = command_string.split(' ')[1..-1]
    raise InvalidCommand, "command #{cmd} invalid" unless AVAILABLE_COMMANDS.include?(cmd)

    send(cmd, *args)
  end

  class InvalidCommand < StandardError; end
end
