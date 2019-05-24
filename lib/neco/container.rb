# frozen_string_literal: true

module Neco
  # Container has two purposes.
  # One is to store commands and execute rollbacks when one command raises an exception.
  # Another is to store environment hash for those commands so that commands can pass data between them.
  class Container
    def initialize(commands: [], environment: {})
      @commands = commands.map {|command| command.new(container: self) }
      @environment = environment
      @called = []
    end

    def call(*args, **params)
      @environment.merge!(params)
      @commands.each do |command|
        command.call(*args, **@environment)
        @called << command
      rescue StandardError
        @called.reverse_each(&:revert)
        break
      end
    end

    def set(key, value)
      @environment[key] = value
    end
  end
end
