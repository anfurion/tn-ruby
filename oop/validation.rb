# frozen_string_literal: true

module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
    base.init_validation_memory
  end

  module ClassMethods
    attr_reader :validation_memory

    def validate(attr_name, check, param = nil)
      case check
      when :presence
        register_presence_check(attr_name)
      when :format
        register_format_check(attr_name, param)
      when :type
        register_type_check(attr_name, param)
      end
    end

    def register_type_check(attr_name, param)
      @validation_memory[:type][attr_name] = param
    end

    def register_format_check(attr_name, param)
      @validation_memory[:format][attr_name] = param
    end

    def register_presence_check(attr_name)
      @validation_memory[:presence] << attr_name
    end

    def init_validation_memory
      @validation_memory = {
        presence: [],
        format: {},
        type: {}
      }
    end
  end

  module InstanceMethods
    def validate!
      check_presence!
      check_format!
      check_type!
    end

    def valid?
      validate!
      true
    rescue StandardError
      false
    end

    def check_presence!
      self.class.validation_memory[:presence]
          .each do |attr_name|
        var_name = "@#{attr_name}".to_sym
        var = instance_variable_get(var_name)
        message = "#{attr_name} must be present"
        raise ArgumentError, message if var.nil? || var.empty?
      end
    end

    def check_type!
      types = self.class.validation_memory[:type]
      types.each_key do |attr_name|
        var_name = "@#{attr_name}".to_sym
        var = instance_variable_get(var_name)
        message = "#{attr_name}  must be a #{types[attr_name]}"
        raise ArgumentError, message unless var.is_a? types[attr_name]
      end
    end

    def check_format!
      formats = self.class.validation_memory[:format]
      formats.each_key do |attr_name|
        var_name = "@#{attr_name}".to_sym
        var = instance_variable_get(var_name)
        message = "#{attr_name}  must be in correct format"
        raise ArgumentError, message if var !~ formats[attr_name]
      end
    end
  end
end
