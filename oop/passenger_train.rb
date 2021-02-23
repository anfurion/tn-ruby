require_relative './instance_counter'
class PassengerTrain < Train
  include InstanceCounter
  def type
    :passenger
  end
end
