require 'spec_helper'
require 'controllers'


describe BlackJackCLI::GameController do
  let (:gcont) { BlackJackCLI::GameController.new }

  describe "#play" do
    it "checks for the playing state" do
      expect(gcont).to receive(:playing?)
      gcont.play
    end
  end

  describe "#playing" do
    it "checks whether the player should continue playing" do
      expect(gcont.playing?).to eq(true)
    end

    it "returns false when the game is over" do
      player = gcont.instance_variable_get(:@player)
      player.instance_variable_set(:@move,'stand')
      expect(gcont.playing?).to eq(false)
    end
  end

end