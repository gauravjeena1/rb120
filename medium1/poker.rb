require "pry"
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

class PokerHand
  def initialize(deck)
    @hand = deal_5_cards(deck)
    @ranks_count = calculate_ranks_count
  end

  def print
    puts "The hand is:"
    puts "-------------"
    puts @hand
    puts "-------------"
  end

  def evaluate
    case
    when royal_flush?     then 'Royal flush'
    when straight_flush?  then 'Straight flush'
    when four_of_a_kind?  then 'Four of a kind'
    when full_house?      then 'Full house'
    when flush?           then 'Flush'
    when straight?        then 'Straight'
    when three_of_a_kind? then 'Three of a kind'
    when two_pair?        then 'Two pair'
    when pair?            then 'Pair'
    else                       'High card'
    end
  end

  private

  def deal_5_cards(deck)
    player_hand = []
    5.times { |_| player_hand << deck.draw }
    player_hand
  end

  def calculate_ranks_count
    count_hash = Hash.new(0)
    @hand.each do |card|
      count_hash[card.rank] += 1
    end
    count_hash
  end

  def royal_flush?
    straight_flush? && @hand.min.rank == 10
  end

  def straight_flush?
    flush? && straight?
  end

  def four_of_a_kind?
    @ranks_count.values.any? { |value| value == 4 }
  end

  def full_house?
    three_of_a_kind? && pair?
  end

  def flush?
    compare_suit = @hand[0].suit
    @hand.all? { |card| card.suit == compare_suit }
    # return false if @hand.any? { |card| card.suit != compare_suit }
    # true
  end

  def straight?
    sorted_ranks = @hand.map { |card| card.value }.sort
    4.times do |index|
      return false if sorted_ranks[index + 1] != sorted_ranks[index] + 1
    end
    true
  end

  def three_of_a_kind?
    @ranks_count.values.any? { |value| value == 3 }
  end

  def two_pair?
    @ranks_count.values.count(2) == 2
  end

  def pair?
    @ranks_count.values.any? { |value| value == 2 }
  end
end

hand = PokerHand.new(Deck.new)
hand.print
puts hand.evaluate

# Danger danger danger: monkey patching for testing purposes.
class Array
  alias_method :draw, :pop
end

# Test that we can identify each PokerHand type.
hand = PokerHand.new([
  Card.new(10,      'Hearts'),
  Card.new('Ace',   'Hearts'),
  Card.new('Queen', 'Hearts'),
  Card.new('King',  'Hearts'),
  Card.new('Jack',  'Hearts')
])
puts hand.evaluate == 'Royal flush'

hand = PokerHand.new([
  Card.new(8,       'Clubs'),
  Card.new(9,       'Clubs'),
  Card.new('Queen', 'Clubs'),
  Card.new(10,      'Clubs'),
  Card.new('Jack',  'Clubs')
])
puts hand.evaluate == 'Straight flush'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(3, 'Diamonds')
])
puts hand.evaluate == 'Four of a kind'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(5, 'Hearts')
])
puts hand.evaluate == 'Full house'

hand = PokerHand.new([
  Card.new(10, 'Hearts'),
  Card.new('Ace', 'Hearts'),
  Card.new(2, 'Hearts'),
  Card.new('King', 'Hearts'),
  Card.new(3, 'Hearts')
])
puts hand.evaluate == 'Flush'

hand = PokerHand.new([
  Card.new(8,      'Clubs'),
  Card.new(9,      'Diamonds'),
  Card.new(10,     'Clubs'),
  Card.new(7,      'Hearts'),
  Card.new('Jack', 'Clubs')
])
puts hand.evaluate == 'Straight'

hand = PokerHand.new([
  Card.new('Queen', 'Clubs'),
  Card.new('King',  'Diamonds'),
  Card.new(10,      'Clubs'),
  Card.new('Ace',   'Hearts'),
  Card.new('Jack',  'Clubs')
])
puts hand.evaluate == 'Straight'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(6, 'Diamonds')
])
puts hand.evaluate == 'Three of a kind'

hand = PokerHand.new([
  Card.new(9, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(8, 'Spades'),
  Card.new(5, 'Hearts')
])
puts hand.evaluate == 'Two pair'

hand = PokerHand.new([
  Card.new(2, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(9, 'Spades'),
  Card.new(3, 'Diamonds')
])
puts hand.evaluate == 'Pair'

hand = PokerHand.new([
  Card.new(2,      'Hearts'),
  Card.new('King', 'Clubs'),
  Card.new(5,      'Diamonds'),
  Card.new(9,      'Spades'),
  Card.new(3,      'Diamonds')
])
puts hand.evaluate == 'High card'

=begin

The following are poker hands, from best to worst:

Straight flush: Five cards of the same suit in sequence (if those five are A, K, Q, J, 10; it is a Royal Flush)
Four of a kind: Four cards of the same rank and any one other card
Full house: Three cards of one rank and two of another
Flush: Five cards of the same suit
Straight: Five cards in sequence (for example, 4, 5, 6, 7, 8)
Three of a kind: Three cards of the same rank
Two pair: Two cards of one rank and two cards of another
One pair: Two cards of the same rank
High card: If no one has a pair, the highest card wins
Royal Flush : Ace, King, Queen, Jack, and 10, all of the same suit.


=end