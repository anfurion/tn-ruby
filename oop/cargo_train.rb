# frozen_string_literal: true

require_relative './instance_counter'

class CargoTrain < Train
  include InstanceCounter
  def type
    :cargo
  end
end
