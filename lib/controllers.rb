module BlackJackCLI

  class GameController
    attr_reader :player

    def initialize
      @dealer = BlackJackCLI::DealerView.new
      @player = BlackJackCLI::PlayerView.new
    end

    def play
      @hands = @dealer.deal
      while playing?
        @player.ask_move
        @comparison = @dealer.compare(@hands)
      end
    end

    def playing?
      return false if @player.move == 'stand' || \
                      [:stand,:bust].include?(@comparison)
      true
    end

  end

end