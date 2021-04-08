# frozen_string_literal: true

module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    attr_reader :validations

    def validate(attr_name, check, options = nil)
      @validations ||= []
      @validations << { attr_name: attr_name, check: check, options: options }
    end
  end

  module InstanceMethods
    def validate!
      self.class.validations.each do |validation|
        method_name = "check_#{validation[:check]}!"
        send(method_name, validation[:attr_name], validation[:options])
      end
    end

    def valid?
      validate!
      true
    rescue StandardError
      false
    end

    def check_presence!(attr_name, _options)
      var_name = "@#{attr_name}".to_sym
      var = instance_variable_get(var_name)
      message = "#{attr_name} must be present"
      raise ArgumentError, message if var.nil? || var.empty?
    end

    def check_type!(attr_name, options)
      var_name = "@#{attr_name}".to_sym
      var = instance_variable_get(var_name)
      message = "#{attr_name}  must be a #{options}"
      raise ArgumentError, message unless var.is_a? options
    end

    def check_format!(attr_name, options)
      var_name = "@#{attr_name}".to_sym
      var = instance_variable_get(var_name)
      message = "#{attr_name}  must be in correct format"
      raise ArgumentError, message if var !~ options
    end
  end
end
