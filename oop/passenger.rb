# frozen_string_literal: true

require_relative './validation'

class Passenger
  include Validation
  validate :name, :presence
  validate :email, :format, /\w*@\w*\.\w*/
  validate :age, :type, Integer
  def initialize(name, email, age)
    @name = name
    @email = email
    @age = age
  end
end
