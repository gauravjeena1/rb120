class Deck
  RANKS = ((2..10).to_a + %w(Jack Queen King Ace)).freeze
  SUITS = %w(Hearts Clubs Diamonds Spades).freeze

  def initialize
    @deck = create_deck
    @deck.shuffle!
  end

  def draw
    if @deck.empty?
      @deck = create_deck.shuffle
    end
    @deck.pop
  end

  private

  def create_deck
    new_deck = []
    SUITS.each do |suit|
      RANKS.each do |rank|
        new_deck << Card.new(rank, suit)
      end
    end
    new_deck
  end
end

class Card
  include Comparable
  CARD_VALUES = {"Jack" => 11, "Queen" => 12, "King" => 13, "Ace" => 14 }
  attr_reader :rank, :suit

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def value
    CARD_VALUES[@rank] ? CARD_VALUES[@rank] : @rank 
  end

  def <=>(other_card)
    value <=> other_card.value
  end

  def to_s
    "#{@rank} of #{@suit}"
  end
end

deck = Deck.new
puts deck
drawn = []
52.times { drawn << deck.draw }
p drawn.count { |card| card.rank == 5 } == 4
p drawn.count { |card| card.suit == 'Hearts' } == 13

drawn2 = []
52.times { drawn2 << deck.draw }
p drawn != drawn2 # Almost always.