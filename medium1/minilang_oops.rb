require 'pry'
class MinilangError < StandardError; end
class EmptyStackError < MinilangError; end
class BadTokenError < MinilangError; end

class Minilang
  VALID_TOKENS = %w(PUSH ADD SUB MULT DIV MOD POP PRINT)

  def initialize(commands)
    @commands = commands.split
    @register = 0
    @stack = []
  end

  def push
    @stack << @register
  end

  def mult
    @register = @stack.pop * @register
  end

  def sub
    @register = @register - @stack.pop
  end

  def add
    @register = @register + @stack.pop
  end

  def div
    @register = @register / @stack.pop
  end

  def mod
    @register = @register % @stack.pop
  end

  def pop
      raise EmptyStackError, "Empty stack!" if @stack.empty?
      @register = @stack.pop
    end

  def print
    puts @register
  end

  def eval
    begin
      @commands.each do |value|
        if value =~ /\A[-+]?\d+\z/
          @register = value.to_i
        elsif VALID_TOKENS.include?(value)
          send(value.downcase)
        else
          raise BadTokenError, "Invalid token: #{value}"
        end
      end
    rescue MinilangError => error
      puts error.message
    end
  end
end

Minilang.new('PRINT').eval
# # 0

Minilang.new('5 PUSH 3 MULT PRINT').eval
# # 15

Minilang.new('5 PRINT PUSH 3 PRINT ADD PRINT').eval
# # 5
# # 3
# # 8

Minilang.new('5 PUSH 10 PRINT POP PRINT').eval
# # 10
# # 5

Minilang.new('5 PUSH POP POP PRINT').eval
# Empty stack!

Minilang.new('3 PUSH PUSH 7 DIV MULT PRINT ').eval
# # 6

Minilang.new('4 PUSH PUSH 7 MOD MULT PRINT ').eval
# # 12

Minilang.new('-3 PUSH 5 XSUB PRINT').eval
# # Invalid token: XSUB

Minilang.new('-3 PUSH 5 SUB PRINT').eval
# # 8

Minilang.new('6 PUSH').eval
# # (nothing printed; no PRINT commands)