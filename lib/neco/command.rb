# frozen_string_literal: true

require 'neco/container'
require 'neco/result'

module Neco
  # Command module is a basic module of Neco.
  # It provides many DSLs for validating input, executing business logic,
  # handling errors and much more.
  module Command
    def self.included(base)
      base.class_eval do
        extend ClassMethods
        include InstanceMethods
      end
    end

    # DSLs
    module ClassMethods
      def main(&blk)
        @main = blk
      end

      def validates(&blk)
        @validation = blk
      end

      def rollback(&blk)
        @rollback = blk
      end

      def call(*args, **params)
        instance = new(*args, **params)
        instance.call
      end
    end

    # When command object is instantiated, either by a class-level call,
    # a container or a user, these methods will be called.
    module InstanceMethods
      def initialize(*args, container: FakeContainer.new(command: self), **params)
        @args = args
        @container = container
        @params = params
      end

      def set(key, value)
        @container.set(key, value)
      end

      def call(*args, **params)
        @args += args
        @params.merge!(params)

        return false unless validate

        main = self.class.instance_variable_get(:@main)
        begin
          instance_exec(*@args, **@params, &main)
          Success.new
        rescue StandardError => e
          Failure.new(exception: e)
        end
      end

      def validate
        validation = self.class.instance_variable_get(:@validation)
        validation ? validation.call(@args, @params) : true
      end

      def revert
        rollback = self.class.instance_variable_get(:@rollback)
        instance_exec(*@args, **@params, &rollback)
      end

      def to_s
        main = self.class.instance_variable_get(:@main)
        main.inspect
      end

      def inspect
        to_s
      end
    end

    # @private
    class FakeContainer
      def initialize(command:)
        @command = command
        @environment = {}
      end

      def set(key, value)
        @environment[key] = value
      end
    end
    private_constant :FakeContainer
  end
end
