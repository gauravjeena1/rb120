# Guessing game medium 1 + 2

class GuessingGame

  def initialize(low, high)
    @low = low
    @high = high
    @range = high - low
    @remaining_guesses = Math.log2(@range).to_i + 1
    @secret_number = (low..high).to_a.sample
  end

  def display_number_of_guesses
    puts "You have #{@remaining_guesses} guesses remaining."
  end

  def remaining_guesses
    if @remaining_guesses < 1
      puts "You have no more guesses. You lost! The number was #{@secret_number}"
    end
    @remaining_guesses
  end

  def valid_input?(value)
    value < @high && value > @low
  end
  
  def get_input
    value = nil
    loop do
      puts "Enter a number between #{@low} and #{@high}:"
      value = gets.chomp.to_i
      break if valid_input?(value)
      print 'Invalid guess!'
    end
    @remaining_guesses -= 1
    value
  end

  def display_result(value)
    case value
      when "low"
      puts "Your guess is too low."
      when "high"
      puts "Your guess is too high."
      when "won"
      puts "You guessed it correctly! You Won! The number was #{@secret_number}"
    end
  end

  def right_guess?(input)
    if input < @secret_number
      "low"
    elsif input > @secret_number
      "high"
    elsif input == @secret_number
      "won"
    end
  end

  def play
    reset
    loop do 
      display_number_of_guesses
      value = right_guess?(get_input)
      display_result(value)
      break if value == "won" || remaining_guesses < 1
    end
  end

  def reset
    @secret_number = rand(@low..@high)
  end
end

game = GuessingGame.new(501, 600)
game.play