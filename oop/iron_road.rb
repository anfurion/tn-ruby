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

train = Train.new(123, :passenger)
pp "Маршрут и поезда созданы"
pp route
pp train
train.take_route(route)
train.hook_wagon
train.hook_wagon
train.hook_wagon
pp train
pp train.route.station(0)
pp train.route.station(1)
train.ride_to_the_next_station
train.unhook_wagon
train.unhook_wagon
train.unhook_wagon
pp train.route.station(0)
pp train.route.station(1)
train.ride_to_the_next_station
sleep(2)
train.ride_to_the_next_station
sleep(2)
train.ride_to_the_next_station
sleep(2)
train.ride_to_the_next_station
sleep(2)
train.ride_to_the_next_station

