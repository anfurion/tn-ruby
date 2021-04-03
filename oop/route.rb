# frozen_string_literal: true

require_relative './accessors'
require_relative './instance_counter'
require_relative './validation'

class Route
  extend Accessors
  include InstanceCounter
  include Validation
  attr_accessor :intermediate_stations

  strong_attr_accessor(:starting_station, Station)
  strong_attr_accessor(:end_station, Station)

  validate :starting_station, :presence

  def initialize(starting_station, end_station)
    self.starting_station = starting_station
    self.end_station = end_station
    @intermediate_stations = []
    register_instance(title)
  end

  def title
    "#{starting_station.name} - #{end_station.name}"
  end

  def info
    [
      title,
      stations.map(&:name)
    ].join ', '
  end

  def stations
    [starting_station] +
      intermediate_stations +
      [end_station]
  end

  def add_intermedite_station(station)
    @intermediate_stations << station
  end

  def delete_intermedite_station
    @intermediate_stations.pop
  end
end
