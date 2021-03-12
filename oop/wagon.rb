require_relative './producer'
class Wagon
  include Producer
  attr_reader :loaded, :capacity

  def initialize(capacity)
    @capacity = capacity
    @loaded = 0
  end

  def load(count = 1)
    if free_capacity >= count
      self.loaded += count
      puts message_loaded
    else
      puts message_overloaded
    end
  end

  def unload(count = 1)
    if loaded >= count
      self.loaded -= count
      puts message_unloaded(count)
    else
      puts message_not_enough(count)
    end
  end

  def free_capacity
    capacity - loaded
  end

  private

  attr_writer :loaded
end
