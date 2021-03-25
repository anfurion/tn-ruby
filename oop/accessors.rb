# frozen_string_literal: true

module Accessors
  def attr_accessor_with_history(*names)
    names.each do |name|
      var_name = "@#{name}_history".to_sym
      define_method(name) { instance_variable_get(var_name).last }
      define_method("#{name}=".to_sym) do |value|
        old_history = instance_variable_get(var_name) || []
        new_history = old_history << value
        instance_variable_set(var_name, new_history)
      end
      define_method("#{name}_history".to_sym) { instance_variable_get(var_name) }
    end
  end

  def strong_attr_accessor(name, klass)
    var_name = "@#{name}".to_sym
    define_method(name) { instance_variable_get(var_name) }
    define_method("#{name}=".to_sym) do |value|
      if value.is_a? klass
        instance_variable_set(var_name, value)
      else
        message = "#{var_name} must be a #{klass}, not #{value.class}"
        raise ArgumentError, message
      end
    end
  end
end
