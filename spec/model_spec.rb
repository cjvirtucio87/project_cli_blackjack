require 'spec_helper'
require 'models'

describe BlackJackCLI::Card do
  let(:card) { BlackJackCLI::Card.new }

  describe "#process" do
    it "converts the card symbol to it's respective value" do
      face = { suit: :diamond, deck: [:king] }
      card.instance_variable_set(:@card, face)
      processed = card.process_card[:deck]['king']
      expect(processed).to eq(10)
    end
  end

end