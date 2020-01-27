# frozen_string_literal: true

RSpec.describe TTY::Exit, "#exit_with" do
  it "exposes exit_with when including a module" do
    stub_const("Command", Class.new do
      include TTY::Exit

      def execute
        exit_with(:usage_error)
      end
    end)

    cmd = Command.new

    expect {
      cmd.execute
    }.to raise_error(SystemExit) do |err|
      expect(err.status).to eq(64)
      expect(err.message).to eq("exit")
    end
  end

  it "prints a custom message with exit code when including a module" do
    output = StringIO.new

    stub_const("Command", Class.new do
      include TTY::Exit

      def initialize(io)
        @io = io
      end

      def execute
        exit_with(:usage_error, "Wrong arguments", io: @io)
      end
    end)

    cmd = Command.new(output)
    expect { cmd.execute }.to raise_error(SystemExit)
    expect(output.string).to eq("Wrong arguments")
  end

  it "prints a predefined message with exit code when including a module" do
    output = StringIO.new

    stub_const("Command", Class.new do
      include TTY::Exit

      def initialize(io)
        @io = io
      end

      def execute
        exit_with(:usage_error, :default, io: @io)
      end
    end)

    cmd = Command.new(output)
    expect { cmd.execute }.to raise_error(SystemExit)

    expect(output.string).to eq("ERROR: Command line usage error")
  end
end
