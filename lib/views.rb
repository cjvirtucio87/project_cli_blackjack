module BlackJackCLI

  class DealerView

    def deal
    end

  end

  class PlayerView
    attr_reader :move

    def initialize
      @stand
    end

    def ask_move
      @move = gets.chomp
    end

  end

end