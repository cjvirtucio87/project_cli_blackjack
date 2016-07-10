module BlackJackCLI

  class Card

    SUITS = [:heart,:spade,:club,:diamond]

    DECK = {
      numbered: rand(2..10),
      face: [:king,:queen,:jack],
      ace: :ace
    }

    def initialize
      @card = {suit: SUITS.sample,deck: DECK[DECK.keys.sample]}
    end

    #Process card for use in view.
    def process_card
      processed = {}
      case @card[:deck]
      when Integer
        processed = { deck: { @card[:deck].to_s => @card[:deck] } }
      when Array
        sampled = @card[:deck].sample
        processed = { deck: { sampled.to_s => 10 } }
      when :ace
        processed = { deck: { 'ace' => [1,11] } }
      end
      processed[:suit] = @card[:suit]
      processed
    end

    #Open up singleton class.
    class << self
      
      #Process a hand and get the total points.
      def process_points(hand)
        hand.values.reduce(0) do |m,v|
          process_points_card(m,v)
        end
      end

      def process_points_card(memo,card)
        case card
        when Hash
          key = card[:deck].keys.first
          add_values(memo,key)
        when Array
          unless card.empty?
            memo += card.reduce(0) { |m,c| process_points_card(memo,c) }
          end
          memo
        end
      end
      
      def add_values(memo,key)
        case
        when /\d/.match(key)
          memo += key.to_i
        when key.length > 3
          memo += 10
        when key == 'ace'
          memo += (memo + 11) > 21 ? 1 : 11
        end
      end

    end

  end

end
