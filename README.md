[![Build Status](https://travis-ci.com/okuramasafumi/neco.svg?branch=master)](https://travis-ci.com/okuramasafumi/neco)
[![Maintainability](https://api.codeclimate.com/v1/badges/d011a37ef8ebf1ea2afd/maintainability)](https://codeclimate.com/github/okuramasafumi/neco/maintainability)

# Neco

Neco is a NEo COmmand pattern library for Ruby.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'neco'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install neco

## Usage

Include `Neco::Command` module and define your command with DSLs like below:

```ruby
class Foo
  include Neco::Command

  validates do |name:|
    name == 'Tama'
  end

  main do |name:|
    puts "Hello, #{name}!"
  end
end

Foo.call(name: 'Tama') # => 'Hello, Tama!'
```

Here, `validates` block defines validations and `main` block defines main logic for the command (simple, right?)

You can also compose multiple commands into one command using `Neco::Composition` module. Neco automatically triggers rollbacks when one of the commands raises an exception.

```ruby
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
# => 'Hello, Tama!'
# => 'Rolling back Command2!'
# => 'Rolling back Command1!'
```

See `examples` directory for details.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/okuramasafumi/neco. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Neco project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/okuramasafumi/neco/blob/master/CODE_OF_CONDUCT.md).
