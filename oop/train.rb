require_relative './producer'
class Train
NUMBER_FORMAT = /^\w{3}-?(\w\w)?$/.freeze
  include Producer
  attr_reader :state, :speed, :number
  attr_accessor :wagons, :route, :route_progress

  @@alltrain = {}

  def initialize(number)
    @number = number
    validate!
    @speed = 0
    @state = :stay
    @route_progress = 0
    @wagons = []
    register_instance
    @@alltrain[number] = self
  end

  def validate!
    raise "number must be a String, not #{number.class}" unless number.is_a?(String)
    raise 'NUMBER FORMAT must be in correct format' if number !~ NUMBER_FORMAT
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  def self.find(number)
    @@alltrain[number]
  end

  def info
    type_info = case type
                when :passenger
                  'Пассажирский'
                when :cargo
                  'Грузовой'
                end

    "#{type_info} поезд №#{number} #{route.title}"
  end

  def wagons_count
    wagons.size
  end

  # Этот медот является публичным,
  # потому что я как пользователь
  # хочу иметь возможность задавать маршрут поезду.
  def take_route(route)
    @route_progress = 0
    @route = route
    arrival_on_current_station
    pp 'Поезд принял маршрут'
  end

  # Это публичный метод, потому что это интерфейс поезда.
  def ride(direction)
    if current_station == route.end_station
      pp 'Поезд уже на конечной станции'
    else
      leave_current_station(direction)
      arrival_on_current_station
    end
  end

  # Этот метод я оставил публичный, так как постоянно вызываю его в irb.
  def hook_wagon(wagon)
    case state
    when :stay
      if wagon.type == type
        @wagons << wagon
        pp "Вагон прицеплен теперь их #{wagons_count}"
      else
        pp "не могу прицепить #{wagon.type} вагон, к #{type} поезду"
      end
    when :rides
      puts 'Cannot hook a wagon, when train rides'
    end
  end

  # Этот метод я оставил публичный, так как постоянно вызываю его в irb.
  def unhook_wagon
    case state
    when :stay
      if wagons_count > 0
        @wagons.pop
        pp "Вагон отцеплен теперь их #{wagons_count}"
      else
        pp 'Не осталось вагонов, которые можно отцепить'
      end
    when :rides
      puts 'Cannot unhook a wagon, when train rides'
    end
  end

  private

  # Приватный, так как он не вызывается из клиентского кода,
  # но вызывается только из публичного метода ride_to_the_next_station
  def arrival_on_current_station
    current_station.take_train(self)
    stop
  end

  # Приватный, так как он не вызывается из клиентского кода,
  # но вызывается только из публичного метода ride_to_the_next_station
  def leave_current_station(direction)
    current_station.train_left(self)
    go(direction)
  end

  # Приватный, так как он не вызывается из клиентского кода
  def next_station
    route.station(route_progress.next) ||
      :finished
  end

  # Это та станция на которой в данный момент находится поезд
  def current_station
    route.stations[route_progress]
  end

  # Этот метод нужен для остановки поезда, и не может быть вызван из вне.
  def stop
    @speed = 0
    @state = :stay
    pp 'Поезд остановился 10 мин'
  end

  # Этот метод нужен для того, чтобы поезд тронулся, и не может быть вызван из вне.
  def go(direction = :forward)
    @speed = 60
    @state = :rides

    case direction
    when :forward
      self.route_progress += 1
    when :backward
      self.route_progress -= 1
    end
    pp 'Поезд тронулся'
  end
end
