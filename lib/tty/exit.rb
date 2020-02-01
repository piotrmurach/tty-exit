# frozen_string_literal: true

require_relative "exit/code"
require_relative "exit/registry"
require_relative "exit/version"

module TTY
  module Exit
    Error = Class.new(StandardError)

    # @api private
    def self.included(base)
      base.instance_eval do
        def register_exit(*args)
          Registry.register_exit(*args)
        end
      end
    end

    NAME_TO_EXIT_CODE = {
      ok: Code::SUCCESS,
      success: Code::SUCCESS,
      error: Code::ERROR,
      shell_misuse: Code::SHELL_MISUSE,

      usage_error: Code::USAGE_ERROR,
      data_err: Code::DATA_ERROR,
      data_error: Code::DATA_ERROR,
      no_input: Code::NO_INPUT,
      no_user: Code::NO_USER,
      no_host: Code::NO_HOST,
      service_unavailable: Code::SERVICE_UNAVAILABLE,
      software_error: Code::SOFTWARE_ERROR,
      system_error: Code::SYSTEM_ERROR,
      system_file_missing: Code::SYSTEM_FILE_MISSING,
      cant_create: Code::CANT_CREATE,
      io_error: Code::IO_ERROR,
      io_err: Code::IO_ERROR,
      temp_fail: Code::TEMP_FAIL,
      protocol: Code::PROTOCOL,
      no_perm: Code::NO_PERM,
      no_permission: Code::NO_PERM,
      config_error: Code::CONFIG_ERROR,
      configuration_error: Code::CONFIG_ERROR,

      cannot_execute: Code::CANNOT_EXECUTE,
      not_found: Code::COMMAND_NOT_FOUND,
      command_not_found: Code::COMMAND_NOT_FOUND,
      invalid_argument: Code::INVALID_ARGUMENT,

      hangup: Code::HANGUP,
      interrupt: Code::INTERRUPT,
      quit: Code::QUIT,
      illegal_instruction: Code::ILLEGAL_INSTRUCTION,
      trace_trap: Code::TRACE_TRAP,
      abort: Code::ABORT,
      kill: Code::KILL,
      bus_error: Code::BUS_ERROR,
      memory_error: Code::MEMORY_ERROR,
      segmentation_fault: Code::MEMORY_ERROR,
      pipe: Code::PIPE,
      alarm: Code::ALARM,
      user1: Code::USER1,
      user2: Code::USER2
    }
    private_constant :NAME_TO_EXIT_CODE

    CODE_TO_EXIT_MESSAGE = {
      Code::SUCCESS => "Successful termination",
      Code::ERROR => "An error occurred",
      Code::SHELL_MISUSE => "Misuse of shell builtins",

      Code::USAGE_ERROR => "Command line usage error",
      Code::DATA_ERROR => "Data format error",
      Code::NO_INPUT => "Cannot open input",
      Code::NO_USER => "User name unknown",
      Code::NO_HOST => "Host name unknown",
      Code::SERVICE_UNAVAILABLE => "Service unavailable",
      Code::SOFTWARE_ERROR => "Internal software error",
      Code::SYSTEM_ERROR => "System error (e.g. can't fork)",
      Code::SYSTEM_FILE_MISSING => "Critical OS file missing",
      Code::CANT_CREATE => "Can't create user output file",
      Code::IO_ERROR => "Input/output error",
      Code::TEMP_FAIL => "Temp failure, user is invited to retry",
      Code::PROTOCOL => "Remote error in protocol",
      Code::NO_PERM => "Permission denied",
      Code::CONFIG_ERROR => "Configuration error",

      Code::CANNOT_EXECUTE => "Command invoked cannot execute",
      Code::COMMAND_NOT_FOUND => "Command not found",
      Code::INVALID_ARGUMENT => "Invalid argument",

      Code::HANGUP => "Hangup detected on controlling terminal or death of controlling process.",
      Code::INTERRUPT => "Interrupted by Control-C",
      Code::QUIT => "Quit program",
      Code::ILLEGAL_INSTRUCTION => "Illegal instruction",
      Code::TRACE_TRAP => "Trace/breakpoint trap",
      Code::ABORT => "Abort program",
      Code::KILL => "Kill program",
      Code::BUS_ERROR => "Access to an undefined portion of a memory object",
      Code::MEMORY_ERROR => "An invalid virtual memory reference or segmentation fault",
      Code::PIPE => "Write on a pipe with no one to read it",
      Code::ALARM => "Alarm clock",
      Code::USER1 => "User-defined signal 1",
      Code::USER2 => "User-defined signal 2",
    }
    private_constant :CODE_TO_EXIT_MESSAGE

    # Check if an exit code is valid, that it's within the 0-255 (inclusive)
    #
    # @param [Integer] code
    #   the code to check
    #
    # @return [Boolean]
    #
    # @api public
    def exit_valid?(code)
      code >= 0 && code <= 255
    end
    module_function :exit_valid?

    # Check if an exit code is already defined by Unix system
    #
    # @param [Integer] code
    #   the code to check
    #
    # @return [Boolean]
    #
    # @api public
    def exit_reserved?(code)
      (code >= Code::SUCCESS && code <= Code::SHELL_MISUSE) ||
        (code >= Code::USAGE_ERROR && code <= Code::CONFIG_ERROR) ||
        (code >= Code::CANNOT_EXECUTE && code <= Code::USER2)
    end
    module_function :exit_reserved?

    # Check if the exit status was successful.
    #
    # @param [Integer] code
    #
    # @api public
    def exit_success?(code)
      code == Code::SUCCESS
    end
    module_function :exit_success?

    # A user friendly explanation of the exit code
    #
    # @example
    #   TTY::Exit.exit_message(:usage_error)
    #   # => "Command line usage error"
    #
    # @param [String,Integer] name_or_code
    #
    # @api public
    def exit_message(name_or_code = :ok)
      (Registry.exits[name_or_code] || {})[:message] ||
      CODE_TO_EXIT_MESSAGE[exit_code(name_or_code)] || ""
    end
    module_function :exit_message

    # Provide exit code for a name or status
    #
    # @example
    #   TTY::Exit.exit_code(:usage_error)
    #   # => 64
    #
    # @param [String,Integer] name_or_code
    #
    # @return [Integer]
    #   the exit code
    #
    # @api public
    def exit_code(name_or_code = :ok)
      case name_or_code
      when String, Symbol
        (Registry.exits[name_or_code.to_sym] || {})[:code] ||
          NAME_TO_EXIT_CODE.fetch(name_or_code.to_sym) do
            raise Error, "Name '#{name_or_code}' isn't recognized."
          end
      when Numeric
        if exit_valid?(name_or_code.to_i)
          name_or_code.to_i
        else
          raise Error, "Provided code outside of the range (0 - 255)"
        end
      else
        raise Error, "Provide a name or a number as an exit code"
      end
    end
    module_function :exit_code

    # Exit this process with a given status code
    #
    # @param [String,Integer] name_or_code
    #   The name for an exit code or code itself
    # @param [String] message
    #   The message to print to io stream
    # @param [IO] io
    #   The io to print message to
    #
    # @return [nil]
    #
    # @api public
    def exit_with(name_or_code = :ok, message = nil, io: $stderr)
      if message == :default
        message = "ERROR(#{exit_code(name_or_code)}): #{exit_message(name_or_code)}"
      end
      io.print(message) if message
      ::Kernel.exit(exit_code(name_or_code))
    end
    module_function :exit_with
  end # Exit
end # TTY
