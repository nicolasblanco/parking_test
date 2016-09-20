class Car
  attr_accessor :color, :plate_number

  def initialize(color:, plate_number:)
    @color, @plate_number = color, plate_number
  end
end
