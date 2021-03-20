# frozen_string_literal: true

module Accessors
  def attr_accessor_with_history(name)
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
