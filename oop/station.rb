require_relative './instance_counter'

class Station
  include InstanceCounter
  attr_reader :name, :trains

  @@all = []

  def initialize(name)
    @name = name
    validate!
    @trains = []
    @@all << self
    register_instance
  end

  def self.all
    @@all
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  def info
    @trains
      .map(&:info)
      .join "\n"
  end

  # Все методы станции публичный так как я их вызываю в irb.

  def recounting_trains
    {
      cargo: select_trains(:cargo).size,
      passenger: select_trains(:passenger).size
    }
  end

  def select_trains(type)
    trains.select { |train| train.type == type }
  end

  def take_train(train)
    @trains << train
    pp "Поезд №#{train.number} Прибыл на станцию #{name}"
  end

  def train_left(train)
    @trains.delete(train)
    pp "Поезд №#{train.number} ушел со станции #{name}"
  end

  private

  def validate!
    raise "name must be a String, not #{name.class}" unless name.is_a?(String)
    raise 'name must have at least 3 letters' if name.length < 3
  end
end
