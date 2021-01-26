class Route
  attr_accessor :intermediate_stations
  attr_reader :starting_station, :end_station

  def initialize(starting_station, end_station)
    @starting_station = starting_station
    @end_station = end_station
    @intermediate_stations = []
  end

  # Все методы маршрута не являются приватными потому что я их вызываю в irb.
  def stations
    [starting_station] +
      intermediate_stations +
      [end_station]
  end

  def add_intermedite_station(station)
    @intermediate_stations << station
  end
end
