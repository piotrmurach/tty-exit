# frozen_string_literal: true

RSpec.describe TTY::Exit, "#exit_code" do
  {
    ok: 0,
    success: 0,
    error: 1,
    shell_misuse: 2,

    usage_error: 64,
    data_err: 65,
    data_error: 65,
    no_input: 66,
    no_user: 67,
    no_host: 68,
    service_unavailable: 69,
    software_error: 70,
    system_error: 71,
    system_file_missing: 72,
    cant_create: 73,
    io_error: 74,
    io_err: 74,
    temp_fail: 75,
    protocol: 76,
    no_perm: 77,
    config_error: 78,

    cannot_execute: 126,
    not_found: 127,
    command_not_found: 127,
    invalid_argument: 128,

    hangup: 129,
    interrupt: 130,
    quit: 131,
    illegal_instruction: 132,
    trace_trap: 133,
    abort: 134,
    kill: 137,
    bus_error: 138,
    memory_error: 139,
    pipe: 141,
    alarm: 142,
    user1: 158,
    user2: 159
  }.map do |name, code|
    it "converts #{name.inspect} to #{code.inspect} exit code" do
      expect(TTY::Exit.exit_code(name)).to eq(code)
    end
  end

  it "accepts name as a string" do
    expect(TTY::Exit.exit_code("data_error")).to eq(65)
  end

  it "accepts a code directly" do
    expect(TTY::Exit.exit_code(65)).to eq(65)
  end

  it "returns 0 code when none provided" do
    expect(TTY::Exit.exit_code).to eq(0)
  end

  it "uses exit status constant" do
    expect(TTY::Exit.exit_code).to eq(TTY::Exit::Code::SUCCESS)
  end

  it "fails to find a code for an unknown name" do
    expect {
      TTY::Exit.exit_code(:unknown)
    }.to raise_error(TTY::Exit::Error, "Name 'unknown' isn't recognized.")
  end

  it "raises when code is of unknown type" do
    expect {
      TTY::Exit.exit_code(Object.new)
    }.to raise_error(TTY::Exit::Error, "Provide a name or a number as an exit code")
  end

  it "raises when code is outside of the allowed range of (0 - 255)" do
    expect {
      TTY::Exit.exit_code(666)
    }.to raise_error(TTY::Exit::Error, "Provided code outside of the range (0 - 255)")
  end
end
