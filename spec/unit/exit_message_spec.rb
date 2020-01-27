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
  }.map do |name, message|
    it "converts #{name.inspect} to a message" do
      expect(TTY::Exit.exit_message(name)).to eq(message)
    end
  end
end
