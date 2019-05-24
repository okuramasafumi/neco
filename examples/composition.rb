# frozen_string_literal: true

require 'bundler/setup'
require 'neco'

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
  main do |cat_name:|
    raise 'OMG!!!'
  end
end

class Bar
  include Neco::Composition

  composes Command1, Command2, Command3
end

Bar.call
