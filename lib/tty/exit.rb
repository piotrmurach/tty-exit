# frozen_string_literal: true

require_relative "exit/version"

module TTY
  module Exit
    Error = Class.new(StandardError)

    # No errors
    EX_SUCCESS = 0

    # Catchall for general errors
    EX_ERROR = 1

    # Missing keyword or command, or permission problem
    # (and diff return code on a failed binary file comparison).
    EX_SHELL_MISUSE = 2
  # The start base code to reduce possibility of clashing with other
    # exit statuses that programs may already run.
    EX_BASE = 64

    # The command was used incorrectly, e.g., with the wrong number
    # of arguments, a bad flag, a bad syntax in a parameter, or whatever.
    EX_USAGE_ERROR = EX_BASE # 64

    # The input data was incorrect in some way.
    # This should only be used for user's data & not system files.
    EX_DATA_ERROR = EX_BASE + 1 # 65

    # An input file (not a system file) did not exist or was not readable.
    EX_NO_INPUT = EX_BASE + 2 # 66

    # The user specified did not exist. This might be used for mail
    # addresses or remote logins.
    EX_NO_USER = EX_BASE + 3 # 67

    # The host specified did not exist. This is used in mail addresses
    # or network requests.
    EX_NO_HOST = EX_BASE + 4 # 68

    # A service is unavailable. This can occur if a support program
    # or file does not exist. This can also be used as a catchall
    # message when something you wanted to do doesn't work,
    # but you don't know why.
    EX_SERVICE_UNAVAILABLE = EX_BASE + 5 # 69

    # An internal software error has been detected. This should be
    # limited to non-operating system related errors as possible.
    EX_SOFTWARE_ERROR = EX_BASE + 6 # 70

    # An operating system error has been detected. This is intended
    # to be used for such things as "cannot fork", "cannot create pipe",
    # or the like. It includes things like getuid returning a user that
    # does not exist in the passwd file.
    EX_SYSTEM_ERROR = EX_BASE + 7 # 71

    # Some system file (e.g., /etc/passwd, /etc/utmp, etc.) does not exist,
    # cannot be opened, or has some sort of error (e.g., syntax error).
    EX_SYSTEM_FILE_MISSING = EX_BASE + 8 #72

    # A (user specified) output file cannot be created.
    EX_CANT_CREATE = EX_BASE + 9 # 73

    # An error occurred while doing I/O on some file.
    EX_IO_ERROR = EX_BASE + 10 # 74

    # Temporary failure, indicating something that is not really an error.
    # For example that a mailer could not create a connection, and the
    # request should be reattempted later.
    EX_TEMP_FAIL = EX_BASE + 11 # 75

    # The remote system returned something that was 'not possible' during
    # a protocol exchange.
    EX_PROTOCOL = EX_BASE + 12 # 76

    # You did not have sufficient permission to perform the operation.
    # This is not intended for file system problems, which should use
    # NO_INPUT or CANT_CREATE, but rather for higher level permissions.
    EX_NO_PERM = EX_BASE + 13 # 77

    # Something was found in an unconfigured or misconfigured state.
    EX_CONFIG_ERROR = EX_BASE + 14 # 78

    # Command invoked cannot execute. This may be due to permission
    # issues.
    EX_CANNOT_EXECUTE = 126

    # "command not found", possible typos in shell command or
    # unrecognized characters
    EX_COMMAND_NOT_FOUND = 127

    # The start base code for the system interrupt signals.
    EX_SIGNAL_BASE = 128

    # Exit takes only integer args in the range 0 - 255,
    # e.g. exit 3.14159 is invalid.
    EX_INVALID_ARGUMENT = EX_SIGNAL_BASE

    # This indicates that program received SIGHUP signal.
    # It means that the controlling pseudo or virtual terminal
    # has been closed.
    EX_HANGUP = EX_SIGNAL_BASE + 1 # 129

    # This indicates that program received SIGINT signal.
    # An interrupt signal that by default this causes the
    # process to terminate.
    EX_INTERRUPT = EX_SIGNAL_BASE + 2 # 130

    # This indicates that program received SIGQUIT signal.
    EX_QUIT = EX_SIGNAL_BASE + 3 # 131

    # This indicates that program received SIGQUIT signal.
    EX_ILLEGAL_INSTRUCTION = EX_SIGNAL_BASE + 4 # 132

    # This indicates that program received SIGTRAP signal.
    EX_TRACE_TRAP = EX_SIGNAL_BASE + 5 # 133

    # This indicates that program received SIGABRT signal.
    EX_ABORT = EX_SIGNAL_BASE + 6 # 134

    # This indicates that program received SIGKILL signal.
    EX_KILL = EX_SIGNAL_BASE + 9 # 137

    # This indicates that program received SIGBUS signal.
    EX_BUS_ERROR = EX_SIGNAL_BASE + 10 # 138

    # This indicates that program received SIGSEGV signal.
    EX_MEMORY_ERROR = EX_SIGNAL_BASE + 11 # 139

    # This indicates that program received SIGPIPE signal.
    EX_PIPE = EX_SIGNAL_BASE + 13 # 141

    # This indicates that program received SIGALARM signal.
    EX_ALARM = EX_SIGNAL_BASE + 14 # 142

    # This indicates that program received SIGUSR1 signal.
    EX_USER1 = EX_SIGNAL_BASE + 30 # 158

    # This indicates that program received SIGUSR2 signal.
    EX_USER2 = EX_SIGNAL_BASE + 31 # 159

    NAME_TO_EXIT_CODE = {
      ok: EX_SUCCESS,
      success: EX_SUCCESS,
      error: EX_ERROR,
      shell_misuse: EX_SHELL_MISUSE,

      usage_error: EX_USAGE_ERROR,
      data_err: EX_DATA_ERROR,
      data_error: EX_DATA_ERROR,
      no_input: EX_NO_INPUT,
      no_user: EX_NO_USER,
      no_host: EX_NO_HOST,
      service_unavailable: EX_SERVICE_UNAVAILABLE,
      software_error: EX_SOFTWARE_ERROR,
      system_error: EX_SYSTEM_ERROR,
      system_file_missing: EX_SYSTEM_FILE_MISSING,
      cant_create: EX_CANT_CREATE,
      io_error: EX_IO_ERROR,
      io_err: EX_IO_ERROR,
      temp_fail: EX_TEMP_FAIL,
      protocol: EX_PROTOCOL,
      no_perm: EX_NO_PERM,
      no_permission: EX_NO_PERM,
      config_error: EX_CONFIG_ERROR,
      configuration_error: EX_CONFIG_ERROR,

      cannot_execute: EX_CANNOT_EXECUTE,
      not_found: EX_COMMAND_NOT_FOUND,
      command_not_found: EX_COMMAND_NOT_FOUND,
      invalid_argument: EX_INVALID_ARGUMENT,

      hangup: EX_HANGUP,
      interrupt: EX_INTERRUPT,
      quit: EX_QUIT,
      illegal_instruction: EX_ILLEGAL_INSTRUCTION,
      trace_trap: EX_TRACE_TRAP,
      abort: EX_ABORT,
      kill: EX_KILL,
      memory_error: EX_MEMORY_ERROR,
      segmentation_fault: EX_MEMORY_ERROR,
      pipe: EX_PIPE,
      alarm: EX_ALARM,
      user1: EX_USER1,
      user2: EX_USER2
    }
    private_constant :NAME_TO_EXIT_CODE

    def exit_code(name_or_code = :ok)
      case name_or_code
      when String, Symbol
        NAME_TO_EXIT_CODE.fetch(name_or_code.to_sym) do
          raise Error, "Name '#{name_or_code}' isn't recognized."
        end
      when Numeric
        name_or_code.to_i
      else
        raise Error, "Provide a name or a number as an exit code"
      end
    end
    module_function :exit_code

    # Exit this process with a given status code
    #
    # @param [String,Integer] name_or_code
    #   The name for an exit code or code itself
    #
    # @api public
    def exit_with(name_or_code = :ok, message = nil, io: $stderr)
      io.print(message) if message
      ::Kernel.exit(exit_code(name_or_code))
    end
    module_function :exit_with
  end # Exit
end # TTY
