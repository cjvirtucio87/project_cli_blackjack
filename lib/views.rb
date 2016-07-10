require_relative 'models.rb'

module BlackJackCLI

  class DealerView

    def deal
      @hand = Hash.new
      [:dealer,:player].each do |k| 
        @hand[k] = { first: Card.new.process,
                     second: Card.new.process } 
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
    attr_accessor :hand
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

    def display_hand
      first_suit = @hand[:first][:suit]
      first_deck = @hand[:first][:deck].keys.first
      second_suit = @hand[:second][:suit]
      second_deck = @hand[:second][:deck].keys.first
      puts "You have the following cards:"
      puts "FIRST: #{first_deck} of #{first_suit}s"
      puts "SECOND: #{second_deck} of #{second_suit}s"
      puts ""
      points_breakdown
    end

    def points_breakdown
      first = @hand[:first][:deck].values.first
      second = @hand[:second][:deck].values.first
      puts "Points breakdown:"
      puts "FIRST: #{first}"
      puts "SECOND: #{second}"
    end

    private
      def validate(move)
        ['hit','stand'].include?(move)
      end

  end

end

player = BlackJackCLI::PlayerView.new
dealer = BlackJackCLI::DealerView.new

player.hand = dealer.deal[:player]
player.display_hand