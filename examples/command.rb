# frozen_string_literal: true

require 'bundler/setup'
require 'neco'

# An example class for validation and main logic
# with block parameter.
class Foo
  include Neco::Command

  validates do |name:|
    name == 'Tama'
  end

  main do |name:|
    puts "Hello, #{name}!"
  end
end

Foo.call(name: 'Tama')
Foo.call(name: 'Pochi')
Foo.new.call(name: 'Tama')
Foo.new(name: 'Pochi').call

class Bar
  include Neco::Command

  main do |answer|
    puts "The ultimate answer is #{answer}"
  end
end

Bar.call(42)
Bar.new(42).call

class Buzz
  include Neco::Command

  main do |user:, params: nil|
    user.update(params)
    p "User is now #{user}"
  end
end

Buzz.new(user: {}).call(params: {name: 'Tama'})
