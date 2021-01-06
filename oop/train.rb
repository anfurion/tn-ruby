class Train
  attr_reader :state, :speed
  attr_accessor :wagons_count, :route, :route_progress

  def initialize(number, type)
    @number = number
    @type = type
    @speed = 0
    @state = :stay
    @wagons_count = 13
    @route_progress = 0
  end

  def ride_to_the_next_station
    leave_current_station
    arrival_on_current_station
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
    route.station(route_progress)
  end

  def take_route(route)
    @route_progress = 0
    @route = route
    arrival_on_current_station
  end

  def stop
    @speed = 0
    @state = :stay
  end

  def go
    @speed = 60
    @state = :rides
    self.route_progress += 1
  end

  def hook_wagon
    case state
    when :stay
      self.wagons_count += 1
    when :rides
      puts 'Cannot hook a wagon, when train rides'
    end
  end

  def unhook_wagon
    case state
    when :stay
      self.wagons_count -= 1
    when :rides
      puts 'Cannot unhook a wagon, when train rides'
    end
  end
end
