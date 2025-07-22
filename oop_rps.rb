class Player
  attr_accessor :move, :name, :points
  attr_reader :all_moves

  MOVES = ['rock', 'paper', 'scissors', 'lizard', 'spock']

  WINNING_KEY = {
    "rock" => ["scissors", "lizard"],
    "paper" => ["rock", "spock"],
    "scissors" => ["lizard", "paper"],
    "spock" => ["scissors", "rock"],
    "lizard" => ["paper", "spock"]
  }

  def initialize
    @name = set_name
    @points = 0
    @all_moves = []
  end

  protected

  attr_writer :all_moves
end

class Human < Player
  def set_name
    human_name = ""
    loop do
      puts "What's your name?"
      human_name = gets.chomp
      break unless human_name.empty?
      puts "Sorry, must enter a name"
    end
    human_name
  end

  def choose
    choice = nil
    loop do
      puts "Please choose rock, paper, scissors, lizard or spock:"
      choice = gets.chomp.downcase
      break if MOVES.include?(choice)
      puts "Sorry, invalid choice"
    end
    self.move = Move.new(choice)
    all_moves << choice
  end

  def score
    self.points += 1
  end
end

class Computer < Player
  def possible_moves(name)
    case name
    when 'Claude'
      ['rock']
    when 'GPT'
      ['rock', 'scissors', 'lizard', 'spock', 'scissors', 'scissors']
    else
      ['rock', 'paper', 'scissors', 'lizard', 'spock']
    end
  end

  def set_name
    self.name = ['Claude', "GPT", "Codi"].sample
  end

  def choose
    self.move = Move.new(possible_moves(name).sample)
    all_moves << move.choice
  end

  def score
    self.points += 1
  end
end

class Move
  attr_accessor :choice

  def initialize(value)
    @choice = value
  end

  def scissors?
    @choice == 'scissors'
  end

  def rock?
    @choice == 'rock'
  end

  def paper?
    @choice == 'paper'
  end

  def lizard?
    @choice == 'lizard'
  end

  def spock?
    @choice == 'spock'
  end

  def >(other_move)
    Player::WINNING_KEY[@choice].include?(other_move.choice)
  end

  def <(other_move)
    Player::WINNING_KEY[other_move.choice].include?(@choice)
  end

  def to_s
    @choice
  end
end

# Game Orchestration Engine
class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors, Lizard, Spock #{human.name}"
    display_score
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors, Lizard, Spock. Good bye!"
  end

  def display_moves
    puts "#{human.name} chose #{human.move}"
    puts "#{computer.name} chose #{computer.move}"
  end

  def who_won?
    if human.move > computer.move
      human
    elsif human.move < computer.move
      computer
    end
  end

  def display_winner(winner)
    winner ? (puts "#{winner.name} won!") : (puts "Its a tie!")
    puts "----------"
  end

  def display_score
    puts "#{human.name} has #{human.points} points"
    puts "#{computer.name} has #{computer.points} points"
  end

  def display_all_moves
    puts "Here are all the moves that were played:"
    human.all_moves.each_with_index do |_, i|
      puts "#{human.name} -> #{human.all_moves[i]} | #{computer.name} -> #{computer.all_moves[i]}"
    end
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if ['y', 'n'].include?(answer)
      puts "Sorry, must be y or n"
    end
    return false if answer.downcase == 'n'
    true if answer.downcase == 'y'
  end

  def play
    display_welcome_message
    loop do
      human.choose
      computer.choose
      display_moves
      winner = who_won?
      display_winner(winner)
      winner.score if winner
      display_score
      break if human.points == 4 || computer.points == 4
    end
    display_goodbye_message
    display_all_moves
  end
end

RPSGame.new.play