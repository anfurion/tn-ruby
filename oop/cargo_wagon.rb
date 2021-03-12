class CargoWagon < Wagon
  def type
    :cargo
  end

  private

  def message_loaded
    "Теперь в вагоне занято #{loaded} объема из #{capacity}"
  end

  def message_overloaded
    'В вагоне не осталось свободного объема'
  end

  def message_unloaded(count)
    "Из вагона выгружено #{count} объема"
  end

  def message_not_enough(count)
    "невозможно выгрузить #{count} объема, потому что в вагоне загружено #{loaded} объема"
  end
end
