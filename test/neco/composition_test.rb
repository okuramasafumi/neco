# frozen_string_literal: true

require_relative '../test_helper'

class Command1
  include Neco::Command

  main do
    set :cat_name, 'Tama'
  end

  rollback do
    puts 'Rolling back Command1!'
  end
end

class Command2
  include Neco::Command

  main do |cat_name:|
    puts "Hello, #{cat_name}!"
  end

  rollback do
    puts 'Rolling back Command2!'
  end
end

class Command3
  include Neco::Command

  # Unused block argument
  main do |_cat_name:|
    raise 'OMG!!!'
  end
end

class CompositeCommand
  include Neco::Composition

  composes Command1, Command2, Command3
end

class CompositionTest < MiniTest::Test
  def test_composition_command_works_without_args
    command_call = -> { CompositeCommand.call }
    assert_output <<~OUTPUT, &command_call
      Hello, Tama!
      Rolling back Command2!
      Rolling back Command1!
    OUTPUT
  end
end
