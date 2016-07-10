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

  end

end
