# frozen_string_literal: true

module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
    base.init_counter
    base.init_list
  end

  module ClassMethods
    attr_reader :instances_count, :instances_list

    def init_counter
      @instances_count = 0
    end

    def init_list
      @instances_list = {}
    end

    def find(key)
      @instances_list[key]
    end

    def counter_increment!
      @instances_count += 1
    end

    def add_in_list(key, instance)
      @instances_list[key] = instance
    end
  end

  module InstanceMethods
    private

    def register_instance(key)
      self.class.counter_increment!
      self.class.add_in_list(key, self)
    end
  end
end
