<div align="center">
  <a href="https://piotrmurach.github.io/tty" target="_blank"><img width="130" src="https://github.com/piotrmurach/tty/raw/master/images/tty.png" alt="tty logo" /></a>
</div>

# TTY::Exit [![Gitter](https://badges.gitter.im/Join%20Chat.svg)][gitter]

[![Gem Version](https://badge.fury.io/rb/tty-exit.svg)][gem]
[![Actions CI](https://github.com/piotrmurach/tty-exit/workflows/CI/badge.svg?branch=master)][gh_actions_ci]
[![Build status](https://ci.appveyor.com/api/projects/status/rtm3po27ouarfrhf?svg=true)][appveyor]
[![Code Climate](https://codeclimate.com/github/piotrmurach/tty-exit/badges/gpa.svg)][codeclimate]
[![Coverage Status](https://coveralls.io/repos/github/piotrmurach/tty-exit/badge.svg)][coverage]
[![Inline docs](http://inch-ci.org/github/piotrmurach/tty-exit.svg?branch=master)][inchpages]

[gitter]: https://gitter.im/piotrmurach/tty
[gem]: http://badge.fury.io/rb/tty-exit
[gh_actions_ci]: https://github.com/piotrmurach/tty-exit/actions?query=workflow%3ACI
[appveyor]: https://ci.appveyor.com/project/piotrmurach/tty-exit
[codeclimate]: https://codeclimate.com/github/piotrmurach/tty-exit
[coverage]: https://coveralls.io/github/piotrmurach/tty-exit
[inchpages]: http://inch-ci.org/github/piotrmurach/tty-exit

> Terminal exit codes for humans and machines.

The goal of this library is to provide human friendly and standard way to use exit status codes in command line applications. Instead of saying `exit(64)`, you can say `exit_with(:usage_error)`. Both indicate a failure to the parent process but the `:usage_error` is so much nicer! Wouldn't you agree? That's why `tty-exit` gathers a list of all the most common exit codes as used by POSIX-compliant tools on different Unix systems for you to use.

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

## Contents

* [1. Usage](#1-usage)
* [2. API](#2-api)
  * [2.1 exit_code](#21-exit_code)
  * [2.2 exit_message](#22-exit_message)
  * [2.3 exit_with](#23-exit_with)
  * [2.4 register_exit](#24-register_exit)
  * [2.5 exit_reserved?](#25-exit_reserved)
  * [2.6 exit_valid?](#26-exit_valid)
  * [2.7 exit_success?](#27-exit_success)
  * [2.8 exit_codes](#28-exit_codes)
  * [2.9 exit_messages](#29-exit_messages)

## 1. Usage

To exit from any program use `exit_with` method. Instead of a number, you can use a readable name for the exit status:

```ruby
TTY::Exit.exit_with(:usage_error)
```

The above will exit program immediately with an exit code indicating a failure:

```ruby
puts $?.exitstatus
# => 64
```

All the reserved exit statuses have a matching exit message. To display a default message, as a second argument to `exit_with` you can pass `:default` value:

```ruby
TTY::Exit.exit_with(:usage_error, :default)
```

That will produce the following user friendly message:

```ruby
# => "ERROR(64): Command line usage error"
```

The preferred way is to include **TTY::Exit** module in your code:

```ruby
class Command
  include TTY::Exit

  def execute
    exit_with(:config_error, :default)
  end
end
```

This will print an error message and return appropriate exit status:

```ruby
cmd = Command.new
cmd.execute
# => "ERROR(78): Configuration Error"
puts $?.exitstatus
# => 78
```

To see the full list of reserved exit codes go to [2.8 exit_codes](#28-exit-codes) section.

## 2. API

### 2.1 exit_code

There are many built-in exit codes that can be referenced using a name.

For example to return an exit code denoting success, you can use `:ok` or `:success`:

```ruby
TTY::Exit.exit_code(:ok) # => 0
TTY::Exit.exit_code(:success) # => 0
```

Any other exit status than 0 indicates a failure of some kind. For example, when a command cannot be found use `:not_found`:

```ruby
TTY::Exit.exit_code(:not_found)
# => 127
```

You can also use an exit code directly:

```ruby
TTY::Exit.exit_code(127)
# => 127
```

### 2.2 exit_message

One of the downsides of exit codes is that they are not very communicative to the user. Why not have both? An exit code and a user friendly message. That's what `exit_message` is for. All the reserved exit codes have corresponding user friendly messages.

For example, when returning exit code `64` for usage error:

```ruby
TTY::Exit.exit_message(:usage_error)
TTY::Exit.exit_message(64)
```

Will return:

```ruby
# => "ERROR(64): Command line usage error"
```

The default messages are used by the `exit_with` method and can be overwritten by a custom one.

### 2.3 exit_with

To exit program with an exit code use `exit_with`. This method accepts a name or a code for the exit status. 

```ruby
TTY::Exit.exit_with(:usage_error)
TTY::Exit.exit_with(64)
```

Both will produce the same outcome.

As a second argument you can specify a user friendly message to be printed to `stderr` before exit. To use predefined messages use `:default` as a value:

```ruby
TTY::Exit.exit_with(:usage_error, :default)
# => "ERROR(64): Command line usage error"
```

Optionally, you can provide a custom message to display to the user.

```ruby
TTY::Exit.exit_with(:usge_error, "Wrong arguments")
# => "Wrong arguments"
```

Finally, you can redirect output to a different stream using `:io` option. By default, message is printed to `stderr`:

```ruby
TTY::Exit.exit_with(:usage_error, io: $stdout)
```

Since `TTY::Exit` is a module, you can include it in your code to get access to all the methods:

```ruby
class Command
  include TTY::Exit

  def execute
    exit_with(:usage_error, :default)
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
    exit_with(:too_long, :default)
  end
end
```

Then when the command gets run:

```ruby
cmd = Command.new
cmd.execute
# =>
# ERROR(7): Argument list too long
```

### 2.5 exit_reserved?

To check if an exit code is already reserved by Unix system use `exit_reserved?`. This is useful in situations where you want to add it your command line application custom exit codes. The check accepts only integer numbers in range 0 to 255 inclusive:

```ruby
TTY::Exit.exit_reserved?(126) # => true
TTY::Exit.exit_reserved?(100) # => false
```

### 2.6 exit_valid?

The exit statuses range from 0 to 255 (inclusive). The `exit_valid?` method helps you check if an exit status is within the range or not.

```ruby
TTY::Exit.exit_valid?(11) # => true
TTY::Exit.exit_valid?(522) # => false
```

### 2.7 exit_success?

Any other exit status than 0 indicates a failure of some kind. The `exit_success?` is a more descriptive way to determine if a program succeeded or not.

```ruby
TTY::Exit.exit_success?(0) # => true
TTY::Exit.exit_success?(7) # => false
```

### 2.8 exit_codes

You can access all the predefined exit codes and their names with `exit_codes` method:

```ruby
TTY::Exit.exit_codes
# =>
# "{:ok=>0, :success=>0, :error=>1, :shell_misuse=>2, :usage_error=>64, :data_error=>65, ... }"
```

### 2.9 exit_messages

To see what default messages are for the predefined exit codes use `exit_messages`:

```ruby
TTY::Exit.exit_messages
# =>
# "{0=>"Successful termination", 1=>"An error occurred", 2=>"Misuse of shell builtins", 64=>"Command line usage error", ... }"
```

The exit statuses range from 0 to 255 (inclusive). Any other exit status than 0 indicates a failure of some kind. The exit codes in the range 64-78 are adapted from the OpenBSD [sysexits.h](https://man.openbsd.org/sysexits.3). The codes between 125 and 128 are reserved for shell statuses as defined in [Advanced Bash Scripting Guide, Appendix E](http://tldp.org/LDP/abs/html/exitcodes.html). The codes in the 129-154 range correspond with the fatal signals as defined in [signal](https://man.openbsd.org/signal.3).


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
