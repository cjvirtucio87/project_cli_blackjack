module BlackJackCLI

  class GameController
    attr_reader :player

    def initialize
      @dealer = BlackJackCLI::DealerView.new
      @player = BlackJackCLI::PlayerView.new
    end

    def run
      @dealer.welcome(@player)
      play
    end

    def play
      @dealer.deal(player)
      loop do
        @player.display_hand
        @player.display_points
        @dealer.handle(@player.ask_move,@player)
      end
    end

  end

end

