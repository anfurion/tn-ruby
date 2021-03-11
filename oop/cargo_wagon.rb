class CargoWagon < Wagon
  attr_reader :loaded, :capacity

  def initialize(capacity)
    @capacity = capacity
    @loaded = 0
  end

  def load_cargo(cargo)
    if capacity > loaded + cargo
      self.loaded += cargo
      puts "Теперь в вагоне занято #{loaded} объема"
    else
      puts 'В вагоне не осталось достаточно свободного объема'
    end
  end

  def unload_cargo(cargo)
    if loaded >= cargo
      self.loaded -= cargo
      puts "Из вагона выгружено #{cargo}"
    else
      puts 'В вагоне недостаточно груза'
    end
  end

  def free_capasity
    capacity - loaded
  end

  def type
    :cargo
  end

  private

  attr_writer :loaded
end
