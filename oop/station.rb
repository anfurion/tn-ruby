# frozen_string_literal: true

require_relative './instance_counter'
require_relative './accessors'

class Station
  include InstanceCounter
  extend Accessors
  attr_reader :trains

  attr_accessor_with_history :name

  def initialize(name)
    self.name = name
    validate!
    @trains = []
    register_instance(name)
  end

  def each_train(&block)
    trains.each(&block)
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
