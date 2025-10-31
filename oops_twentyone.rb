module Hand
  def busted?
    self.total > 21
  end

  def total
    total_sum = self.cards.sum { |card| Card::CARD_VALUES[card] }

    if ace_count >= 1
      ace_count.times do |_|
        break if total_sum <= 21  
        total_sum -= 10
      end
    end
    total_sum
  end

  def ace_count
    self.cards.count(:ace)
  end
end

class Player
  include Hand
  attr_accessor :cards
  attr_reader :name

  def initialize(name)
    @cards = []
    @name = name
  end
end

class Dealer
  include Hand
  attr_accessor :cards

  def initialize
    @cards = []
  end
end

class Deck
  attr_accessor :deck
  def initialize
    @deck = {
              ace: 4, two: 4, three: 4, four: 4, five: 4, six: 4, seven: 4, 
              eight: 4, nine: 4, ten: 4, jack: 4, queen: 4,king: 4 
            }
  end

  def update_deck(card)
    deck[card] -= 1
  end

  def deal(participant)
    2.times do |_|
      card = deck.keys.sample
      participant.cards << card
      update_deck(card)
    end
  end

  def deal_one
    card = deck.keys.sample
    update_deck(card)
    card
  end

end

class Card
    CARD_VALUES = {
                  ace: 11, two: 2, three: 3, four: 4, five: 5, six: 6,
                  seven: 7, eight: 8, nine: 9, ten: 10, jack: 10, queen: 10, king: 10
                }

  def initialize
    @value = card_value?
  end

  def ace_value?(total)
    (total + 10 > 21) ? 1 : 10
  end

  def card_value?(card)
    CARD_VALUES[card]
  end
end

class Game
  def initialize
    @deck = Deck.new
    @player = Player.new(player_name)
    @dealer = Dealer.new
  end

  attr_accessor :player, :dealer
  attr_accessor :deck

  def start
    deal_cards
    show_initial_cards
    player_turn
    dealer_turn if !player.busted?
    show_result
  end

  def who_won?
    case dealer.total <=> player.total
    when 1
      puts "Dealer won!"
    when -1
      puts "Player won!"
    when 0
      puts "Its a Draw!"
    end
  end

  def show_result
    puts "==============================="
    if player.busted?
      puts "#{player.name} busted! Dealer wins!"
    elsif dealer.busted?
      puts "Dealer busted! Player wins!"
    else
      who_won?
      puts "Final Hands: "
      puts "Dealer has : #{dealer.cards}"
      puts "Dealer total = #{dealer.total}"
      puts "Player has : #{player.cards}"
      puts "Player total = #{player.total}"
    end
    puts "====== Game Over =============="
  end

  def deal_cards
    deck.deal(player)
    deck.deal(dealer)
  end

  def player_name
    puts "Who is playing today?"
    gets.chomp
  end

  def show_initial_cards
    puts "#{player.name} got: #{player.cards.join(" and ")}"
    puts "Dealer got: #{dealer.cards.first}"
    puts "--------------------------"
  end

  def player_turn
    loop do
      puts "Do you want to hit(h) or stay(s)?"
      choice = gets.chomp

      case choice
      when "h"
        card = @deck.deal_one
        player.cards << card
        puts "Player now has : #{player.cards}"
      when "s"
        puts "You chose to stay!"
        puts "--------------------------"
        break
      else
        puts "Not a valid choice press h or s only"
      end
      break if player.busted?
    end
  end

  def dealer_turn
    puts "Now dealer will play..."
    sleep(3)
    loop do
      if dealer.total < 17
        card = @deck.deal_one
        dealer.cards << card
        puts "Dealer now has : #{dealer.cards}"
      else
        break
      end
    end
  end
end

Game.new.start