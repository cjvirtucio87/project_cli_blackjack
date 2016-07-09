require 'spec_helper'
require 'views'

describe BlackJackCLI::PlayerView do
  let(:player) { BlackJackCLI::PlayerView.new }
  
  describe "#ask_move" do
    it "stores a valid player input" do
      allow(player).to receive(:gets).and_return('hit')
      player.ask_move
      expect(player.move).to eq('hit')
    end
  end

  describe "#validate" do
    it "accepts valid player input" do
      expect(player.instance_eval { validate('hit') }).to eq(true)
    end

    it "rejects invalid player input" do
      expect(player.instance_eval { validate('dhsaudsaudhsau') }).to eq(false)
    end
  end

end

describe BlackJackCLI::DealerView do
  let(:dealer) { BlackJackCLI::DealerView.new }

  describe "#deal" do
    it "stores the player's hand" do
      expect(dealer.deal[:player]).to be_an_instance_of(Fixnum)
    end

    it "stores the dealer's hand" do
      expect(dealer.deal[:dealer]).to be_an_instance_of(Fixnum)
    end
  end
end