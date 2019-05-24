# frozen_string_literal: true

require 'neco/container'

module Neco
  # Composition is a module for users to compose multiple commands.
  module Composition
    def self.included(base)
      base.class_eval do
        extend ClassMethods
      end
    end

    # DSLs for composition pattern.
    # `compose` is meant to be used in a class definition
    # while `call` is meant to be used when users actually execute commands.
    module ClassMethods
      def composes(*commands)
        @container = Container.new(commands: commands)
      end

      def call(*args, **params)
        @container.call(args, params)
      end
    end
  end
end
