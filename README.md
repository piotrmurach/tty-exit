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

The goal of this library is to standardize possible exit status codes for command line applications. It attempts to select most common exit codes as used by POSIX-compliant tools on different Unix systems.

The exit statuses range from 0 to 255 (inclusive). Any other exit status than 0 indicates a failure of some kind. The exit codes in the range 64-78 are adapted from the OpenBSD [sysexits.h](https://man.openbsd.org/sysexits.3). The codes between 125 and 128 are reserved for shell statuses as defined in [Advanced Bash Scripting Guide, Appendix E](http://tldp.org/LDP/abs/html/exitcodes.html). The codes in the 129-154 range correspond with the fatal signals as defined in [signal](https://man.openbsd.org/signal.3).

**TTY::Exit** provides independent terminal exit codes component for [TTY](https://github.com/piotrmurach/tty) toolkit.

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
```

Every exit status name corresponds with exit code:

```ruby
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

## 2. API

### 2.1 exit_code

### 2.2 exit_message

### 2.3 exit_with

To exit program with an exit code use `exit_with`. This method accepts a name or a code for the exit status. 

```ruby
TTY::Exit.exit_with(:usage_error)
TTY::Exit.exit_with(64)
```

Both will produce the same outcome.

```ruby
# => "ERROR: Command line usage error"
```

Optionally, you can provide a custom message to display to the user.

```ruby
TTY::Exit.exit_with(:usge_error, "Wrong arguments")
```

Finally, you can redirect output to a different stream using `:io` option. By default, message is printed to `stderr`:

```ruby
TTY::Exit.exit_with(:usage_error, io: $stdout)
```

Since `TTY::Exit` is a module, you can include in your code to get access to all the methods:

```ruby
class Command
  include TTY::Exit

  def execute
    exit_with(:usage_error)
  end
end
```

### 2.4 register_exit

If the provided exit codes don't match your needs, you can add your own using the `register_exit` method. 

For example, to register a custom exit with `:too_long` name and the status `7` that will notify user and programs about too many arguments do:

```ruby
class Command
  include TTY::Exit

  register_exit(:too_long, 7, "Argument list too long")

  def execute
    exit_with(:too_long)
  end
end
```

Then when the command gets run:

```ruby
cmd = Command.new
cmd.execute
# =>
# ERROR: Argument list too long
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
