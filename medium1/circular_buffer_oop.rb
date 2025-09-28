class CircularBuffer

  def initialize(size)
    @buffer = Array.new
    @max_size = size
  end

  def get
    @buffer.pop
  end

  def array_size_max?
    @buffer.size >= @max_size
  end

  def put(num)
    get if array_size_max?

    # @buffer.unshift(num)    #performance wise using unshift or creating a new array are same
    @buffer = [num] + @buffer
  end
end

buffer = CircularBuffer.new(3)
puts buffer.get == nil

buffer.put(1)
buffer.put(2)
puts buffer.get == 1


buffer.put(3)
buffer.put(4)

puts buffer.get == 2
buffer.put(5)
buffer.put(6)
buffer.put(7)
puts buffer.get == 5
puts buffer.get == 6
puts buffer.get == 7
puts buffer.get == nil

buffer = CircularBuffer.new(4)
puts buffer.get == nil

buffer.put(1)
buffer.put(2)
puts buffer.get == 1

buffer.put(3)
buffer.put(4)
puts buffer.get == 2

buffer.put(5)
buffer.put(6)
buffer.put(7)
puts buffer.get == 4
puts buffer.get == 5
puts buffer.get == 6
puts buffer.get == 7
puts buffer.get == nil