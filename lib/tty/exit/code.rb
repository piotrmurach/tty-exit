# frozen_string_literal: true

module TTY
  module Exit
    module Code
      # No errors
      SUCCESS = 0

      # Catchall for general errors
      ERROR = 1

      # Missing keyword or command, or permission problem
      # (and diff return code on a failed binary file comparison).
      SHELL_MISUSE = 2

      # The start base code to reduce possibility of clashing with other
      # exit statuses that programs may already run.
      BASE = 64

      # The command was used incorrectly, e.g., with the wrong number
      # of arguments, a bad flag, a bad syntax in a parameter, or whatever.
      USAGE_ERROR = BASE # 64

      # The input data was incorrect in some way.
      # This should only be used for user's data & not system files.
      DATA_ERROR = BASE + 1 # 65

      # An input file (not a system file) did not exist or was not readable.
      NO_INPUT = BASE + 2 # 66

      # The user specified did not exist. This might be used for mail
      # addresses or remote logins.
      NO_USER = BASE + 3 # 67

      # The host specified did not exist. This is used in mail addresses
      # or network requests.
      NO_HOST = BASE + 4 # 68

      # A service is unavailable. This can occur if a support program
      # or file does not exist. This can also be used as a catchall
      # message when something you wanted to do doesn't work,
      # but you don't know why.
      SERVICE_UNAVAILABLE = BASE + 5 # 69

      # An internal software error has been detected. This should be
      # limited to non-operating system related errors as possible.
      SOFTWARE_ERROR = BASE + 6 # 70

      # An operating system error has been detected. This is intended
      # to be used for such things as "cannot fork", "cannot create pipe",
      # or the like. It includes things like getuid returning a user that
      # does not exist in the passwd file.
      SYSTEM_ERROR = BASE + 7 # 71

      # Some system file (e.g., /etc/passwd, /etc/utmp, etc.) does not exist,
      # cannot be opened, or has some sort of error (e.g., syntax error).
      SYSTEM_FILE_MISSING = BASE + 8 #72

      # A (user specified) output file cannot be created.
      CANT_CREATE = BASE + 9 # 73

      # An error occurred while doing I/O on some file.
      IO_ERROR = BASE + 10 # 74

      # Temporary failure, indicating something that is not really an error.
      # For example that a mailer could not create a connection, and the
      # request should be reattempted later.
      TEMP_FAIL = BASE + 11 # 75

      # The remote system returned something that was 'not possible' during
      # a protocol exchange.
      PROTOCOL = BASE + 12 # 76

      # You did not have sufficient permission to perform the operation.
      # This is not intended for file system problems, which should use
      # NO_INPUT or CANT_CREATE, but rather for higher level permissions.
      NO_PERM = BASE + 13 # 77

      # Something was found in an unconfigured or misconfigured state.
      CONFIG_ERROR = BASE + 14 # 78

      # Command invoked cannot execute. This may be due to permission
      # issues.
      CANNOT_EXECUTE = 126

      # "command not found", possible typos in shell command or
      # unrecognized characters
      COMMAND_NOT_FOUND = 127

      # The start base code for the system interrupt signals.
      SIGNAL_BASE = 128

      # Exit takes only integer args in the range 0 - 255,
      # e.g. exit 3.14159 is invalid.
      INVALID_ARGUMENT = SIGNAL_BASE

      # This indicates that program received SIGHUP signal.
      # It means that the controlling pseudo or virtual terminal
      # has been closed.
      HANGUP = SIGNAL_BASE + 1 # 129

      # This indicates that program received SIGINT signal.
      # An interrupt signal that by default this causes the
      # process to terminate.
      INTERRUPT = SIGNAL_BASE + 2 # 130

      # This indicates that program received SIGQUIT signal.
      QUIT = SIGNAL_BASE + 3 # 131

      # This indicates that program received SIGQUIT signal.
      ILLEGAL_INSTRUCTION = SIGNAL_BASE + 4 # 132

      # This indicates that program received SIGTRAP signal.
      TRACE_TRAP = SIGNAL_BASE + 5 # 133

      # This indicates that program received SIGABRT signal.
      ABORT = SIGNAL_BASE + 6 # 134

      # This indicates that program received SIGKILL signal.
      KILL = SIGNAL_BASE + 9 # 137

      # This indicates that program received SIGBUS signal.
      BUS_ERROR = SIGNAL_BASE + 10 # 138

      # This indicates that program received SIGSEGV signal.
      MEMORY_ERROR = SIGNAL_BASE + 11 # 139

      # This indicates that program received SIGPIPE signal.
      PIPE = SIGNAL_BASE + 13 # 141

      # This indicates that program received SIGALARM signal.
      ALARM = SIGNAL_BASE + 14 # 142

      # This indicates that program received SIGUSR1 signal.
      USER1 = SIGNAL_BASE + 30 # 158

      # This indicates that program received SIGUSR2 signal.
      USER2 = SIGNAL_BASE + 31 # 159
    end # Code
  end # Exit
end # TTY
