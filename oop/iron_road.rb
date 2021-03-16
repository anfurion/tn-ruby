# frozen_string_literal: true

require_relative './route'
require_relative './station'
require_relative './train'
require_relative './passenger_train'
require_relative './cargo_train'
adler = Station.new('adler')
sochi = Station.new('sochi')
tuapse = Station.new('tuapse')
krasnodar = Station.new('krasnodar')
rostov = Station.new('rostov_glavnyi')
moscow = Station.new('moscow')

route = Route.new(adler, moscow)
route.add_intermedite_station(sochi)
route.add_intermedite_station(tuapse)
route.add_intermedite_station(krasnodar)
route.add_intermedite_station(rostov)

train = PassengerTrain.new(123, 13)
pp 'Маршрут и поезда созданы'
pp route
pp train
train.take_route(route)
train.hook_wagon
train.hook_wagon
train.hook_wagon
pp train
pp train.route.stations[0]
pp train.route.stations[1]
train.ride_to_the_next_station
train.unhook_wagon
train.unhook_wagon
train.unhook_wagon
pp train.route.stations[0]
pp train.route.stations[1]
train.ride_to_the_next_station
sleep(2)
train.ride_to_the_next_station
sleep(2)
train.ride_to_the_next_station
sleep(2)
train.ride_to_the_next_station
sleep(2)
train.ride_to_the_next_station

another_train = Train.new(321, 4)
another_train.unhook_wagon
another_train.unhook_wagon
another_train.unhook_wagon
another_train.unhook_wagon
another_train.unhook_wagon

cargo1 = CargoTrain.new(444, 4)
cargo2 = CargoTrain.new(555, 4)
cargo3 = CargoTrain.new(666, 4)
pass1 = PassengerTrain.new(111, 13)
pass2 = PassengerTrain.new(222, 13)
pass3 = PassengerTrain.new(333, 13)

tuapse.take_train(cargo1)
tuapse.take_train(cargo2)
tuapse.take_train(cargo3)
pp tuapse
pp tuapse.recounting_trains

tuapse.take_train(pass1)
tuapse.take_train(pass2)
tuapse.take_train(pass3)

pp tuapse
pp tuapse.recounting_trains
tuapse.train_left(cargo1)
tuapse.train_left(cargo2)
tuapse.train_left(pass2)
pp tuapse.recounting_trains
