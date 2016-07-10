require 'spec_helper'
require 'models'

describe BlackJackCLI::Card do
  let(:card) { BlackJackCLI::Card.new }

  describe "#process" do
    it "converts the card symbol to it's respective value" do
      face = { suit: :diamond, deck: [:king,:queen,:jack] }
      card.instance_variable_set(:@card, face)
      key = card.process[:deck].keys.first
      expect(card.process[:deck][key]).to eq(10)
    end
  end

end