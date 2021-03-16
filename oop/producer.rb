# frozen_string_literal: true

module Producer
  def self.included(base)
    base.class_eval do
      attr_accessor :producer
    end
  end
end
