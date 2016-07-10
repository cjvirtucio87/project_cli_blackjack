require_relative 'models.rb'

module BlackJackCLI

  class DealerView

    def welcome(player)
      puts "Welcome to blackjack. What's your name?"
      player.name = gets.chomp
      puts "Well met, #{player.name}."
    end

    def deal(player)
      puts "Dealing cards..."
      @hands = Hash.new
      [:dealer,:player].each do |k| 
        @hands[k] = { first: Card.new.process_card,
                      second: Card.new.process_card } 
      end
      @hand = @hands[:dealer]
      player.hand = @hands[:player]
      @hands
    end

    def compare(hands)
      p_hand = Card.process_points(hands[:player])
      d_hand = Card.process_points(hands[:dealer])
      case 
      when p_hand > 21
        :bust
      when p_hand > d_hand
        :stand
      end
    end

  end

  class PlayerView
    attr_accessor :hand, :name
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
      puts "You have the following cards:\n" +
           "FIRST: #{first_deck} of #{first_suit}s\n" +
           "SECOND: #{second_deck} of #{second_suit}s\n" +
           "\n"
    end

    def display_points
      first = @hand[:first][:deck].values.first
      second = @hand[:second][:deck].values.first
      puts "Points breakdown:\n" +
           "FIRST: #{first}\n" + 
           "SECOND: #{second}\n" +
           "TOTAL: #{points = Card.process_points(hand)}"
      points
    end

    private
      
      def validate(move)
        ['hit','stand'].include?(move)
      end

  end

end