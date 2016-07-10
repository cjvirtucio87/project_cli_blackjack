require_relative 'models.rb'

module BlackJackCLI

  class DealerView

    def deal
      @hand = Hash.new
      [:dealer,:player].each do |k| 
        @hand[k] = { first: Card.new.process_card,
                     second: Card.new.process_card } 
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
      puts "You have the following cards:\n" +
           "FIRST: #{first_deck} of #{first_suit}s\n" +
           "SECOND: #{second_deck} of #{second_suit}s\n" +
           "\n"
      points_breakdown
    end

    def points_breakdown
      first = @hand[:first][:deck].values.first
      second = @hand[:second][:deck].values.first
      puts "Points breakdown:\n" +
           "FIRST: #{first}\n" + 
           "SECOND: #{second}\n" +
           "TOTAL: #{points = process_points}"
      points
    end

    private
      def validate(move)
        ['hit','stand'].include?(move)
      end

      def process_points
        [:first,:second].reduce(0) do |m,e|
          key = @hand[e][:deck].keys.first
          add_values(m,key)
        end
      end
      
      def add_values(memo,key)
        if /\d/.match(key)
          memo += key.to_i
        elsif key.length > 3
          memo += 10
        elsif key == 'ace'
          memo += (memo + 11) > 21 ? 1 : 11
        end
      end

  end

end