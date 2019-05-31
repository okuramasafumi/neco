# frozen_string_literal: true

require_relative '../test_helper'

class Foo
  include Neco::Command

  main do |answer|
    puts "The ultimate answer is #{answer}"
  end
end

class Bar
  include Neco::Command

  validates do |name:|
    name == 'Tama'
  end

  main do |name:|
    puts "Hello, #{name}!"
  end
end

class CommandTest < MiniTest::Test
  def test_command_with_args_class_level_call
    assert_output("The ultimate answer is 42\n") { Foo.call(42) }
  end

  def test_command_with_keyword_args_class_level_call
    assert_output("Hello, Tama!\n") { Bar.call(name: 'Tama') }
  end

  def test_command_with_keyword_args_instance_level_call_with_args
    assert_output("Hello, Tama!\n") { Bar.new.call(name: 'Tama') }
  end

  def test_command_with_keyword_args_instance_level_call_with_initialization_with_args
    assert_output("Hello, Tama!\n") { Bar.new(name: 'Tama').call }
  end
end
