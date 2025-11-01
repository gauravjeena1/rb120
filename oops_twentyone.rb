CARD_VALUES = {
  ace: 11, two: 2, three: 3, four: 4, five: 5, six: 6,
  seven: 7, eight: 8, nine: 9, ten: 10, jack: 10, queen: 10, king: 10
}

module Hand
  def busted?
    total > 21
  end

  def total
    total_sum = cards.sum { |card| CARD_VALUES[card] }

    ace_count.times do |_|
      break if total_sum <= 21
      total_sum -= 10
    end

    total_sum
  end

  def ace_count
    cards.count(:ace)
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
      eight: 4, nine: 4, ten: 4, jack: 4, queen: 4, king: 4
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

  def available_cards
    deck.select { |_, count| count > 0 }.keys
  end

  def deal_one
    card = available_cards.sample
    update_deck(card)
    card
  end
end

class Game
  def start
    deal_cards
    show_initial_cards
    player_turn
    dealer_turn if !player.busted?
    show_result
  end

  private

  def initialize
    @deck = Deck.new
    @player = Player.new(player_name)
    @dealer = Dealer.new
  end

  attr_accessor :player, :dealer, :deck

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

  def display_hands
    puts "Final Hands: "
    puts "Dealer has : #{dealer.cards}"
    puts "Dealer total = #{dealer.total}"
    puts "Player has : #{player.cards}"
    puts "Player total = #{player.total}"
  end

  def show_initial_cards
    puts "#{player.name} got: #{player.cards.join(' and  ')}"
    puts "Dealer got: #{dealer.cards.first}"
    puts "--------------------------"
  end

  def show_result
    puts "==============================="
    if player.busted?
      puts "#{player.name} busted! Dealer wins!"
    elsif dealer.busted?
      puts "Dealer busted! Player wins!"
    else
      who_won?
    end
    puts "==============================="
    display_hands
    puts "====== Game Over =============="
  end

  def deal_cards
    deck.deal(player)
    deck.deal(dealer)
  end

  def player_name
    name = ""
    loop do
      puts "Who is playing today?"
      name = gets.chomp
      break if !name.empty?
      puts "Please enter a valid name"
    end
    name
  end

  def player_hits
    card = @deck.deal_one
    player.cards << card
    puts "Player now has : #{player.cards}"
  end

  def player_choice
    answer = nil
    loop do
      puts "Do you want to hit(h) or stay(s)?"
      answer = gets.chomp.downcase
      break if ['h', 's'].include?(answer)
      puts "Not a valid choice press h or s only"
    end
    answer
  end

  def display_stay_message
    puts "You chose to stay!"
    puts "--------------------------"
  end

  def player_turn
    loop do
      choice = player_choice

      if choice == "s"
        display_stay_message
        break
      end

      player_hits
      break if player.busted?
    end
  end

  def dealer_turn
    puts "Now dealer will play..."
    sleep(3)
    loop do
      break unless dealer.total < 17
      card = @deck.deal_one
      dealer.cards << card
      puts "Dealer now has : #{dealer.cards}"
    end
  end
end

Game.new.start
