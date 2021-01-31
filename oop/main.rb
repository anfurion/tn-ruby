require_relative './route'
require_relative './station'
require_relative './train'
require_relative './passenger_train'
require_relative './cargo_train'
require_relative './wagon'
require_relative './cargo_wagon'
require_relative './passenger_wagon'
class Main
  def initialize
    @stations = {}
    @routes = []
    @trains = {}
  end

  def menu
    puts <<-MENU
     1 - Создавать станции
     2 - Создавать поезда
     3 - Создавать маршруты и управлять станциями в нем (добавлять, удалять)
     4 - Назначать маршрут поезду
     5 - Добавлять вагоны к поезду
     6 - Отцеплять вагоны от поезда
     7 - Перемещать поезд по маршруту вперед и назад
     8 - Просматривать список станций и список поездов на станции
    MENU

    puts 'Выберите пункт из меню'
    num = gets.to_i

    case num
    when 1 then create_station
    when 2 then create_trains
    when 3 then create_routes
      # when 4 then assign_route_to_train
      # when 5 then add_wagons_to_a_train
      # when 6 then unhook_wagon_from_train
      # when 7 then move_train
      # when 8 then list_stations_and_trains
    end
  end

  def create_station
    puts 'Введите имя станции'
    name = gets.chomp
    @stations[name.to_sym] = Station.new(name)
    puts @stations
    menu
  end

  def create_trains
    puts <<-TRAINS_MENU
    Выберите тип поезда
    1. Пассажирский
    2. Грузовой
    TRAINS_MENU
    type = gets.chomp.to_i

    puts 'Введите номер поезда'
    number = gets.chomp.to_i

    case type
    when 1
      @trains[number] = PassengerTrain.new(number)
    when 2
      @trains[number] = CargoTrain.new(number)
    end
    puts @trains

    menu
  end

  def route_menu
    puts <<-ROUTE_MENU
    Выберите пункт из меню#{' '}
    1. Создать маршрут
    2. Добавить станцию в маршрут
    3. Удалить последнюю промежуточную станцию
    4. Выйти в главное меню
    ROUTE_MENU
    action = gets.chomp.to_i

    case action
    when 1 then create_routes
    when 2 then add_intermedite_station_to_route
    # when 3 then delete_intermedite_station_to_route
    when 4 then menu
    end
  end

  def create_routes
    puts 'Создаем маршрут'
    puts 'Выберите начало маршрута из доступных станций'
    puts @stations.keys
    start_name = gets.chomp.to_sym
    starting_station = @stations[start_name]
    puts 'Выберите конец маршрута из доступных станций'
    puts @stations.keys
    end_name = gets.chomp.to_sym
    end_station = @stations[end_name]

    route = Route.new(starting_station, end_station)
    @routes << route
    puts 'Известные маршруты'
    puts show_routes
    route_menu
  end

  def add_intermedite_station_to_route
    puts 'добавляем промежуточную станцию в маршрут'
    puts 'Выберем маршрут из существующих'
    puts show_routes
    route_number = gets.chomp.to_i
    route = @routes[route_number]

    puts 'Выберите станцию из доступных станций'
    puts @stations.keys
    station_name = gets.chomp.to_sym
    station = @stations[station_name]
    route.add_intermedite_station(station)
    puts route
    route_menu
  end

  def show_routes
    @routes.map.with_index { |route, index| "#{index}: #{route.title}" }
  end
end
Main.new.menu
