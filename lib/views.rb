require 'pry'
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
                      second: Card.new.process_card,
                      additional: [] } 
      end
      @hand = @hands[:dealer]
      player.hand = @hands[:player]
      @hands
    end

    def handle(move,player)
      case move
      when 'hit'
        player.hand[:additional].push Card.new.process_card
      when 'stand'
        compare(player)
      end
    end

    def compare(player)
      # binding.pry
      p_hand = Card.process_points(@hands[:player])
      d_hand = Card.process_points(@hands[:dealer])
      case 
      when p_hand > 21
        player.display_points
        puts "Sorry, #{player.name}. Better luck next time."
        abort
      when p_hand > d_hand
        player.display_points
        puts "You win!"
        abort
      when p_hand < d_hand
        player.display_points
        puts "Didn't beat my hand. Maybe next time."
        abort
      end
    end

  end

  class PlayerView
    attr_accessor :hand, :name
    attr_reader :move

    def ask_move
      begin
        @move = gets.chomp.downcase
        raise StandardError unless validate(@move)
      rescue StandardError
        puts "Invalid move. Try again"
        retry
      end
      @move
    end

    def display_hand
      first = stringify_card(@hand[:first])
      second = stringify_card(@hand[:second])
      additional = @hand[:additional].map { |card| stringify_card(card) }
      puts "You have the following cards:\n" +
           "FIRST: #{first}\n" +
           "SECOND: #{second}\n"
      unless additional.empty?
        puts "Additional cards:"
        additional.each { |card| puts card }
        puts ""
      end
    end

    def display_points
      puts "TOTAL: #{points = Card.process_points(@hand)}"
      points
    end

    private
      
      def validate(move)
        ['hit','stand'].include?(move)
      end

      def stringify_card(card)
        "#{card[:deck].keys.first} of #{card[:suit]}"
      end

  end

end