module BlackJackCLI

  class DealerView

    def deal
      @hand
    end

    def compare(hands)
      case 
      when hands[:player] > 21
        return :bust
      when hands[:player] > hands[:dealer]
        return :stand
      end
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