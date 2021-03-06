require "private_methods"

class Example
  extend PrivateMethods

  private_method :saying do
    "Wow"
  end

  public_method :say do
    puts saying
  end
end

class Ex2 < Example
  private_method :saying do
    "Example 2"
  end

  public_method :wow do |*param, &b|
    3.times { |y| b.call y }
  end
end

Ex2.new.wow("WOW", 'Nada') { |x| p x }

#puts "\n\nNew Ex2"
#p Ex2.new.send :saying
puts "\n\nNew Ex2"
Ex2.new.say
#puts "\n\nNew Ex2"
#Ex2.new.say_something
