# frozen_string_literal: true

RSpec.describe TTY::Exit, "#exit_reserved?" do
  {
    0 => true,
    2 => true,
    3 => false,
    63 => false,
    64 => true,
    125 => false,
    128 => true,
    159 => true,
    160 => false,
  }.each do |code, reserved|
    it "determines exit #{code.inspect} as #{reserved ? "reserved" : "not reserved"}" do
      expect(TTY::Exit.exit_reserved?(code)).to eq(reserved)
    end
  end
end
