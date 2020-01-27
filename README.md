<div align="center">
  <a href="https://piotrmurach.github.io/tty" target="_blank"><img width="130" src="https://cdn.rawgit.com/piotrmurach/tty/master/images/tty.png" alt="tty logo" /></a>
</div>

# TTY::Exit [![Gitter](https://badges.gitter.im/Join%20Chat.svg)][gitter]

[![Gem Version](https://badge.fury.io/rb/tty-exit.svg)][gem]
[![Build Status](https://secure.travis-ci.org/piotrmurach/tty-exit.svg?branch=master)][travis]
[![Build status](https://ci.appveyor.com/api/projects/status/rtm3po27ouarfrhf?svg=true)][appveyor]
[![Code Climate](https://codeclimate.com/github/piotrmurach/tty-exit/badges/gpa.svg)][codeclimate]
[![Coverage Status](https://coveralls.io/repos/github/piotrmurach/tty-exit/badge.svg)][coverage]
[![Inline docs](http://inch-ci.org/github/piotrmurach/tty-exit.svg?branch=master)][inchpages]

[gitter]: https://gitter.im/piotrmurach/tty
[gem]: http://badge.fury.io/rb/tty-exit
[travis]: http://travis-ci.org/piotrmurach/tty-exit
[appveyor]: https://ci.appveyor.com/project/piotrmurach/tty-exit
[codeclimate]: https://codeclimate.com/github/piotrmurach/tty-exit
[coverage]: https://coveralls.io/github/piotrmurach/tty-exit
[inchpages]: http://inch-ci.org/github/piotrmurach/tty-exit

> Terminal exit codes.

The goal of this library is to standardize possible exit status codes for command line applications. It attempts to select exit codes as used by POSIX compliant tools on different Unix systems.

**TTY::Exit** provides independent exit codes components for [TTY](https://github.com/piotrmurach/tty) toolkit.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'tty-exit'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install tty-exit

## 1. Usage

To exit from any code use `exit_with` and provide name for the exit status:

```ruby
TTY::Exit.exit_with(:usage_error)
# => "ERROR: Command line usage error"
```ruby

Every exit status name corresponds with exit code:

````
puts $?.exitstatus
# => 64
```

You can also include it as a module:

```ruby
class Command
  include TTY::Exit

  def execute
    exit_with(:config_error)
  end
end
```

This will print an error message and return appropriate exit status:

```ruby
cmd = Command.new
cmd.execute
# => "ERROR: Configuration Error"
puts $?.exitstatus
# => 78
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/piotrmurach/tty-exit. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/piotrmurach/tty-exit/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the TTY::Exit project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/piotrmurach/tty-exit/blob/master/CODE_OF_CONDUCT.md).

## Copyright

Copyright (c) 2020 Piotr Murach. See LICENSE for further details.
