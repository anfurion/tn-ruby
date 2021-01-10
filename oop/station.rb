class Station
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def take_train(train)
    @trains << train
    pp "Поезд №#{train.number} Прибыл на станцию #{name}"
  end

  def train_left(train)
    @trains.delete(train)
    pp "Поезд №#{train.number} ушел со станции #{name}"
  end
end
