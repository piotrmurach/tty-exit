# frozen_string_literal: true

RSpec.describe TTY::Exit, "#exit_message" do
  {
    success: "Successful termination",
    error: "An error occurred",
    shell_misuse: "Misuse of shell builtins",

    usage_error: "Command line usage error",
    data_error: "Data format error",
    no_input: "Cannot open input",
    no_user: "User name unknown",
    no_host: "Host name unknown",
    service_unavailable: "Service unavailable",
    software_error: "Internal software error",
    system_error: "System error (e.g. can't fork)",
    system_file_missing: "Critical OS file missing",
    cant_create: "Can't create user output file",
    io_error: "Input/output error",
    temp_fail: "Temp failure, user is invited to retry",
    protocol: "Remote error in protocol",
    no_perm: "Permission denied",
    config_error: "Configuration error",

    cannot_execute: "Command invoked cannot execute",
    command_not_found: "Command not found",
    invalid_argument: "Invalid argument",

    hangup: "Hangup detected on controlling terminal or death of controlling process.",
    interrupt: "Interrupted by Control-C",
    quit: "Quit program",
    illegal_instruction: "Illegal instruction",
    trace_trap: "Trace/breakpoint trap",
    abort: "Abort program",
    kill: "Kill program",
    bus_error: "Access to an undefined portion of a memory object",
    memory_error: "An invalid virtual memory reference or segmentation fault",
    pipe: "Write on a pipe with no one to read it",
    alarm: "Alarm clock",
    user1: "User-defined signal 1",
    user2: "User-defined signal 2",
  }.map do |name, message|
    it "converts #{name.inspect} to a message" do
      expect(TTY::Exit.exit_message(name)).to eq(message)
    end
  end
end
