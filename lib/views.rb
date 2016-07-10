module BlackJackCLI

  class DealerView

    def deal
      @hand = Hash.new
      [:dealer,:player].each do |k| 
        @hand[k] = { first: Card.new.process } 
        @hand[k] = { second: Card.new.process }
      end
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

    def ask_move
      begin
        @move = gets.chomp
        raise StandardError unless validate(@move)
      rescue StandardError
        puts "Invalid move. Try again"
        retry
      end
      @move
    end

    private
      def validate(move)
        ['hit','stand'].include?(move)
      end

  end

end