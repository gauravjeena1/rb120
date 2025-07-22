class Vehicle
  attr_reader :make, :model
  
  def initialize(make, model)
    @make = make
    @model = model
  end

  def to_s
    "#{make} #{model}"
  end
end

class Car < Vehicle
  def wheels
    4
  end
end

class Motorcycle < Vehicle
  def wheels
    2
  end
end

class Truck < Vehicle
  attr_reader :payload

  def initialize(make, model, payload)
    super(make, model)
    @payload = payload
  end

  def wheels
    6
  end
end

truck = Truck.new("Ford", "Truck", 120)
car = Car.new("BMW", "Sedan")
motor = Motorcycle.new("BMW", "Racer")

puts truck
puts car
puts motor


# class Car
#   attr_accessor :mileage

#   def initialize
#     @mileage = 0
#   end

#   def increment_mileage(miles)
#     total = mileage + miles
#     self.mileage = total
#   end

#   def print_mileage
#     puts mileage
#   end
# end

# car = Car.new
# car.mileage = 5000
# car.increment_mileage(678)
# car.print_mileage  # should print 5678

# p '43'.upcase!

# name = 'Fluffy'
# fluffy = Pet.new(name)
# puts fluffy.name # Fluffy
# puts fluffy # My name is FLUFFY
# puts fluffy.name # FLUFFY
# puts name # FLUFFY

# class Person
#   # attr_accessor :name

#   def name
#     [@first_name, @last_name].join(" ")
#   end

#   def name=(full_name)
#     @first_name = full_name.split.first
#     @last_name = full_name.split.last
#   end
# end

# person1 = Person.new
# person1.name = 'John Doe'
# puts person1.name

# class Person
#   # attr_reader :name

#   def name
#     @name.clone
#   end

#   def initialize(name)
#     @name = name
#   end
# end

# person1 = Person.new('James')
# p person1.name.object_id
# puts person1.name.object_id
# puts person1.name.object_id

# class Animal
#   def move
#     puts "crawl"
#   end
# end

# class Fish < Animal
#   def move
#     puts "swim"
#   end
# end

# class Cat < Animal
#   def move
#     puts "walk"
#   end
# end

# # Sponges and Corals don't have a separate move method - they don't move
# class Sponge < Animal; end
# class Coral < Animal; end

# animals = [Fish.new, Cat.new, Sponge.new, Coral.new]
# animals.each { |animal| animal.move }


# class Vehicle
#   attr_reader :year

#   def initialize(year)
#     @year = year
#     start_engine
#   end
# end

# class Truck < Vehicle
#   def start_engine
#     puts 'Ready to go!'
#   end
# end

# truck1 = Truck.new(1994)
# class Vehicle
#   attr_reader :year

#   def initialize(year)
#     @year = year
#     puts "self is: #{self.class}"  # This will show "Truck"
#     start_engine
#   end
# end

# class Truck < Vehicle
#   def start_engine
#     puts 'Ready to go!'
#   end
# end

# class Van < Truck

# end

# truck1 = Truck.new(1994)
# van1 = Van.new(1996)
# puts truck1.year

# class Dog
#   def speak
#     'bark!'
#   end

#   def swim
#     'swimming!'
#   end

#   def run
#     'running!'
#   end

#   def jump
#     'jumping!'
#   end

#   def fetch
#     'fetching!'
#   end
# end

# class Bulldog < Dog
#   # super Dog
#   def swim
#     "Bulldog can't swim!"
#   end
# end

# class Cat < Dog
#   def swim
#     " Cat can't swim!"
#   end

#   def fetch
#     "Cat fetching!"
#   end

# end

# teddy = Dog.new
# # puts teddy.speak           # => "bark!"
# # puts teddy.swim           # => "swimming!"
# bull = Bulldog.new
# puts bull.swim
# puts bull.speak

# katze = Cat.new
# p katze.speak
# p katze.swim

# class Person
#   def initialize(age)
#     @age = age
#   end

#   def compare_ages(other_person)
#     # This won't work - can't call private method on another object
#     p age #> other_person.age  # NoMethodError
    
#     # Would need to use a public method instead
#     puts "Cannot compare ages directly with private methods"
#   end

#   private

#   def age
#     @age
#   end
# end

# person1 = Person.new(25)
# person2 = Person.new(30)

# # This fails - private method called from outside the class
# # person1.age  # NoMethodError: private method `age' called

# person1.compare_ages(person2)  # Cannot compare ages directly

# class Person
#   attr_writer :secret

#   def compare_secret(person)
#     @secret == person.secret
#   end

#   protected

#   attr_reader :secret
# end

# person1 = Person.new
# person1.secret = 'Shh.. this is a secret!'

# person2 = Person.new
# person2.secret = 'Shh.. this is a different secret!'

# puts person1.compare_secret(person2)

# class Person
#   attr_accessor :secret

#   def initialize
#     @secret
#   end
  
# end

# person1 = Person.new
# person1.secret = 'Shh.. this is a secret!'
# puts person1.secret

# class Cat
#   attr_reader :name

#   def initialize(name)
#     @name = name
#   end

#   def to_s
#     "I'm #{@name}!"
#   end
# end

# kitty = Cat.new('Sophie')
# puts kitty

# class Cat
#   attr_accessor :name
#   @@cat_count = 0
#   CATCOLOR = "purple"

#   def initialize(name)
#     @name = name
#     @@cat_count += 1
#   end

#   def rename(new_name)
#     @name = new_name
#   end
  
#   def identify
#     self
#   end

#   def self.generic_greeting
#     puts "Hello! I'm a cat!"
#   end

#   def personal_greeting
#     puts "Hello! My name is #{self.name}!"
#   end

#   def self.total
#     puts @@cat_count
#   end

#   def greet
#     puts "Hello! My name is #{@name} and I'm a #{CATCOLOR} cat!"
#   end
# end

# kitty = Cat.new('Sophie')
# kitty.greet
# # p kitty.name
# kitty.rename('Chloe')
# p kitty.name
# p kitty.identify
# Cat.generic_greeting
# kitty.personal_greeting
# kitty1 = Cat.new('Sophie')
# kitty2 = Cat.new('Sophie')
# Cat.total

# class Cat
#   def self.generic_greeting
#     puts "Hello! I'm a cat!"
#   end
# end

# kitty = Cat.new
# kitty.class.generic_greeting # => undefined method `generic_greeting' for #<Cat:0x007fbdd3875e40> (NoMethodError)

# module Walkable
#   def walk
#     puts "Let's go for a walk"
#   end
# end


# class Cat
#   include Walkable
#   attr_accessor :name
#   def initialize(name)
#     @name = name
#   end

#   def greet
#     puts "Hello! My name is #{name}!"
#   end
# end

# kitty = Cat.new('Sophie')
# kitty.greet
# kitty.name = "Luna"
# kitty.greet
# kitty.walk
# class Person
#   attr_accessor :first_name, :last_name

#   def initialize(full_name)
#     parts = full_name.split
#     @first_name = parts.first
#     @last_name = parts.size > 1 ? parts.last : ''
#   end

#   def name
#     "#{first_name} #{last_name}".strip
#   end

#   def name=(name)
#     parts = name.split
#     @first_name = parts.first
#     @last_name = parts.size > 1 ? parts.last : ''
#   end

#   def to_s
#     name
#   end
# end

# bob = Person.new('Robert')
# p bob.name                  # => 'Robert'
# p bob.first_name            # => 'Robert'
# p bob.last_name             # => ''
# bob.last_name = 'Smith'
# p bob.name                  # => 'Robert Smith'

# bob.name = "John Adams"
# p bob.first_name            # => 'John'
# p bob.last_name             # => 'Adams'

# bob = Person.new('Robert Smith')
# rob = Person.new('Robert Smith')

# p bob.name == rob.name
# p bob == rob

# bob = Person.new('bob')
# p bob.name                  # => 'bob'
# bob.name = 'Robert'
# p bob.name                  # => 'Robert'

# class Student
#   attr_reader :name

#   def initialize(name, grade)
#     @name = name
#     @grade = grade
#   end

#   def better_grade_than?(student)
#     self.grade < student.grade
#   end

#   protected
  
#   attr_reader :grade
# end

# joe = Student.new("Joe", "A")
# # puts joe.grade

# bob = Student.new("Bob", "B")

# puts "Well done!" if joe.better_grade_than?(bob)


# module PassengerVehicle
#   def passenger_car
#     puts "A Car is a passenger vehicle"
#   end
# end

# class Vehicle
#   attr_accessor :color
#   attr_reader :year, :model
#   NUMBER_OF_DOORS = 4
#   @@number_of_vehicles = 0

#   def initialize(name, year, color, model)
#     @name = name
#     @year = year
#     @color = color
#     @model = model
#     @current_speed = 0
#     @@number_of_vehicles += 1
#   end

#   def self.gas_mileage(liters, km)
#     puts "#{km / liters} km per liters of gas"
#   end

#   def brake(number)
#     @current_speed -= number
#     puts "You push the brake and decelerate #{number}kmh"
#   end

#   def shut_off
#     @current_speed = 0
#     puts "Let's park this car"
#   end

#   def speed_up(number)
#     @current_speed += number
#     puts "You push the gas and accelerate #{number}kmh"
#   end

#   def current_speed
#     puts "You are now going #{@current_speed}kmh"
#   end

#   def spray_paint(new_color)
#     @color = new_color
#   end

#   def self.number_of_vehicles
#     puts "There are #{@@number_of_vehicles} vehicles"
#   end

#   def age_of_vehicle
#     puts "Age of the vehicle is #{calculate_age_of_vehicle} years"
#   end

#   private

#   def calculate_age_of_vehicle
#     t = Time.new
#     t.year - @year.to_i
#   end

# end

# class MyTruck < Vehicle
#   NUMBER_OF_DOORS = 2
  

#   def to_s
#     "My truck is a #{color}, #{year}, #{model}"
#   end
# end

# class MyCar < Vehicle
#   include PassengerVehicle
#   def what_is_self
#     self
#   end

#   def to_s
#     "My car is a #{color}, #{year}, #{model}"
#   end

# end
# puts "-****-"
# bmw = MyCar.new("bmw", 1993, "black", "sedan")
# new_car = MyCar.new("new", 1992, "white", "suv")
# puts bmw
# # MyCar.gas_mileage(13, 351)
# puts "---------"
# truck = MyTruck.new("ford", 2014, "black", "truck")
# puts truck
# puts "---------"

# puts bmw.age_of_vehicle

# puts Vehicle.number_of_vehicles
# puts bmw.passenger_car

# puts Vehicle.ancestors

# puts MyCar.ancestors

# p bmw.what_is_self
# p new_car.self

# puts "Car color is #{bmw.color}"
# bmw.color = "red"
# puts "Car color changed to #{bmw.color}"
# puts bmw.color

# puts bmw.year

# # bmw.year = 1993
# bmw.spray_paint("yellow")
# puts "Your newly painted color is #{bmw.color}"

# puts bmw.model


# bmw.speed_up(20)
# bmw.current_speed

# bmw.speed_up(20)
# bmw.current_speed

# bmw.brake(20)
# bmw.current_speed

# bmw.brake(20)
# bmw.current_speed

# bmw.shut_off
# bmw.current_speed


# class GoodDog
#   def initialize(name)
#     @name = name
#   end

#   def speak
#     "#{@name} says Arf!"
#   end

#   def get_name #getter method
#     name = @name
#   end

#   def name=(new_name) #setter method
#     @name = new_name
#   end

# end

# sparky = GoodDog.new("Sparky")
# puts sparky.speak

# fido  = GoodDog.new("Fido")
# puts fido.speak

# puts sparky.get_name

# sparky.name=("Gab") #setter method
# puts sparky.speak


# # class GoodDog
# #   def initialize(name)
# #     puts "This object was initialized"
# #     puts name
# #   end
# # end

# # sparky = GoodDog.new("Gab")