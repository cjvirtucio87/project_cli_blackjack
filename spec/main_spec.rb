require 'spec_helper'
require 'controllers'
require 'main'

describe "#main" do

  it "creates a new GameController instance" do
    expect(BlackJackCLI::GameController).to receive(:new)
    BlackJackCLI::main
  end

end