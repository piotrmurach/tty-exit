# frozen_string_literal: true

RSpec.describe TTY::Exit, "#exit_success?" do
  it "verifies exit code 0 as successful" do
    expect(TTY::Exit.exit_success?(0)).to eq(true)
  end

  it "verifies exit code other than 0 as unsuccessful" do
    expect(TTY::Exit.exit_success?(1)).to eq(false)
  end
end
