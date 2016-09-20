class Parking
  attr_accessor :capacity
  attr_reader :slots

  def initialize(capacity:)
    @capacity, @slots = capacity, []
  end

  def <<(car)
    raise NoSlotsAvailable if capacity == @slots.compact.size

    if (index = @slots.find_index(&:nil?))
      @slots[index] = car
    else
      @slots << car
      index = @slots.size - 1
    end

    index + 1
  end

  def slots_hash
    @slots.each_with_object({}) do |slot, h|
      h[(@slots.index(slot) + 1).to_s] = slot if slot
    end
  end

  def delete_at(index)
    @slots[index - 1] = nil
  end

  class NoSlotsAvailable < StandardError; end
end
