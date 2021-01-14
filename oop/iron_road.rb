require './route'
require './station'
require './train'

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

train = Train.new(123, :passenger, 13)
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

another_train = Train.new(321, :cargo, 4)
another_train.unhook_wagon
another_train.unhook_wagon
another_train.unhook_wagon
another_train.unhook_wagon
another_train.unhook_wagon

cargo1 = Train.new(444, :cargo, 4)
cargo2 = Train.new(555, :cargo, 4)
cargo3 = Train.new(666, :cargo, 4)
pass1 = Train.new(111, :passenger, 13)
pass2 = Train.new(222, :passenger, 13)
pass3 = Train.new(333, :passenger, 13)

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
