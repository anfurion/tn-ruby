# frozen_string_literal: true

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

  # rubocop:disable Metrics/CyclomaticComplexity
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
    when 4 then assign_route_to_train
    when 5 then add_wagons_to_a_train
    when 6 then unhook_wagon_from_train
    when 7 then move_train
    when 8 then list_stations_and_trains
    end
  end
  # rubocop:enable Metrics/CyclomaticComplexity

  def create_station
    puts 'Введите имя станции'
    name = gets.chomp
    @stations[name.to_sym] = Station.new(name)
  rescue StandardError => e
    puts e.message
  ensure
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
    number = gets.chomp.to_s

    case type
    when 1
      @trains[number] = PassengerTrain.new(number)
    when 2
      @trains[number] = CargoTrain.new(number)
    end
  rescue StandardError => e
    puts e.message
  ensure
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
    when 3 then delete_intermedite_station_from_route

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
  rescue StandardError => e
    puts e.message
  ensure
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
    puts route.info
    route_menu
  end

  def delete_intermedite_station_from_route
    puts 'удаляем промежуточную станцию из маршрута'
    puts 'Выберем маршрут из существующих'
    puts show_routes
    route_number = gets.chomp.to_i
    route = @routes[route_number]
    deleted_station = route.delete_intermedite_station
    route.info
    puts "Удалена станция #{deleted_station.name}"
    route_menu
  end

  def show_routes
    @routes.map.with_index { |route, index| "#{index}: #{route.info}" }
  end

  def assign_route_to_train
    puts 'Назначаем маршрут для поезда'
    puts 'Выберите поезд'
    puts @trains
    train_number = gets.chomp.to_s
    train = @trains[train_number]

    puts 'Выберем маршрут из существующих'
    puts show_routes
    route_number = gets.chomp.to_i
    route = @routes[route_number]
    train.take_route(route)
    menu
  end

  def add_wagons_to_a_train
    puts 'Добавляем вагон к поезду'
    puts 'Выберите поезд'
    puts @trains
    train_number = gets.chomp.to_s
    train = @trains[train_number]

    wagon = case train.type
            when :passenger
              puts 'Введите количество пассажирских мест в вагоне'
              seats_count = gets.chomp.to_i
              PassengerWagon.new(seats_count)
            when :cargo
              puts 'Введите объем в вагоне'
              capacity = gets.chomp.to_i
              CargoWagon.new(capacity)

            end
    train.hook_wagon(wagon)
    menu
  end

  def unhook_wagon_from_train
    puts 'Отцепляем вагон от поезда'
    puts 'Выберите поезд'
    puts @trains
    train_number = gets.chomp.to_s
    train = @trains[train_number]

    train.unhook_wagon
    menu
  end

  def move_train
    puts 'Двигаем поезд'
    puts 'Выберите поезд'
    puts @trains
    train_number = gets.chomp.to_s
    train = @trains[train_number]

    puts <<-DIRECTION_MENU
    Выберите направления движения поезда
    1. Вперед
    2. Назад
    DIRECTION_MENU
    puts 'Выберите пункт из меню'
    num = gets.to_i

    case num
    when 1 then train.ride(:forward)
    when 2 then train.ride(:backward)
    end
    menu
  end

  def list_stations_and_trains
    puts 'Выберите станцию из доступных станций'
    puts @stations.keys
    station_name = gets.chomp.to_sym
    station = @stations[station_name]
    puts "На станции #{station_name}"
    puts station.info
    menu
  end
end
Main.new.menu
