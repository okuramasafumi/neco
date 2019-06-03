# frozen_string_literal: true

module Neco
  # Base class of Result
  class Result
  end

  # Success is returned when the command executed successfully.
  class Success < Result
    def success?
      true
    end

    def failure?
      false
    end
  end

  # Failure is returned when the command failed.
  # This class has several extra information because failure has many ways to achieve
  # while success has only one way.
  class Failure < Result
    def initialize(exception:)
      @exception = exception
    end

    def success?
      false
    end

    def failure?
      true
    end

    def message
      @exception.message
    end
  end
end
