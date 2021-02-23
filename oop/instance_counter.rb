module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
    base.init_counter
  end

  module ClassMethods
    def init_counter
      @instances = 0
    end

    def instances
      @instances
    end

    def instances_increment!
      @instances += 1
    end
  end

  module InstanceMethods
    private

    def register_instance
      self.class.instances_increment!
    end
  end
end
