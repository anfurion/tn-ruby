class Train
  attr_reader :state, :speed, :number, :type
  attr_accessor :wagons_count, :route, :route_progress

  def initialize(number, type, wagons_count)
    @number = number
    @type = type
    @speed = 0
    @state = :stay
    @wagons_count = wagons_count
    @route_progress = 0
  end

  def ride_to_the_next_station
    if current_station == route.end_station
      pp 'Поезд уже на конечной станции'
    else
      leave_current_station
      arrival_on_current_station
    end
  end

  def arrival_on_current_station
    current_station.take_train(self)
    stop
  end

  def leave_current_station
    current_station.train_left(self)
    go
  end

  def next_station
    route.station(route_progress.next) ||
      :finished
  end

  def current_station
    route.stations[route_progress]
  end

  def take_route(route)
    @route_progress = 0
    @route = route
    arrival_on_current_station
    pp 'Поезд принял маршрут'
  end

  def stop
    @speed = 0
    @state = :stay
    pp 'Поезд остановился 10 мин'
  end

  def go
    @speed = 60
    @state = :rides
    self.route_progress += 1
    pp 'Поезд тронулся'
  end

  def hook_wagon
    case state
    when :stay
      self.wagons_count += 1
      pp "Вагон прицеплен теперь их #{wagons_count}"
    when :rides
      puts 'Cannot hook a wagon, when train rides'
    end
  end

  def unhook_wagon
    case state
    when :stay
      if wagons_count > 0
        self.wagons_count -= 1
        pp "Вагон отцеплен теперь их #{wagons_count}"
      else
        pp 'Не осталось вагонов, которые можно отцепить'
      end
    when :rides
      puts 'Cannot unhook a wagon, when train rides'
    end
  end
end
