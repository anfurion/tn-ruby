class PassengerWagon < Wagon
  def type
    :passenger
  end

  private

  def message_loaded
    "Теперь в вагоне занято #{loaded} мест из #{capacity}"
  end

  def message_overloaded
    'В вагоне не осталось свободных мест'
  end

  def message_unloaded(count)
    "Вагон покинули #{count} пассажиров"
  end

  def message_not_enough(count)
    "невозможно высадить #{count} пассажиров, потому что в вагоне всего #{loaded} пассажиров"
  end
end
