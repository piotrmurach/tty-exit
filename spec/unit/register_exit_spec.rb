# frozen_string_literal: true

RSpec.describe TTY::Exit, "#register_exit" do
  it "registers a custom exit code and invokes it by name" do
    output = StringIO.new

    stub_const("Command", Class.new do
      include TTY::Exit

      register_exit(:too_long, 7, "Argument list too long")

      def initialize(io)
        @io = io
      end

      def execute
        exit_with(:too_long, :default, io: @io)
      end
    end)

    cmd = Command.new(output)
    expect { cmd.execute }.to raise_error(SystemExit)

    expect(output.string).to eq("ERROR: Argument list too long")
  end

  it "registers a custom exit code and invokes it by code" do
    output = StringIO.new

    stub_const("Command", Class.new do
      include TTY::Exit

      register_exit(:too_long, 7, "Argument list too long")

      def initialize(io)
        @io = io
      end

      def execute
        exit_with(7, :default, io: @io)
      end
    end)

    cmd = Command.new(output)
    expect { cmd.execute }.to raise_error(SystemExit)

    expect(output.string).to eq("ERROR: Argument list too long")
  end

  it "registers already existing code" do
    output = StringIO.new

    stub_const("Command", Class.new do
      include TTY::Exit

      register_exit(:usage_error, 64, "Wrong number of arguments")

      def initialize(io)
        @io = io
      end

      def execute
        exit_with(:usage_error, :default, io: @io)
      end
    end)

    cmd = Command.new(output)
    expect { cmd.execute }.to raise_error(SystemExit)

    expect(output.string).to eq("ERROR: Wrong number of arguments")
  end
end
