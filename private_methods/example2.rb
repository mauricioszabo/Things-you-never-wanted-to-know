require "private_methods"

class Example2
  extend PrivateMethods

  public_method :say do |&b|
    something(10, 20) { |x| p x }
  end

  private_method :something do |*args, &b|
    something2
    #b.call(:Deiz)
  end

  private_method :something2 do
    puts "WOW"
  end
end

class Example3 < Example2
  private_method :something2 do
    puts "WOW do Example3"
  end
end

puts "\nExample2.new"
Example2.new.say
puts "\nExample3.new"
Example3.new.say
puts "\nExample3.new.send"
Example3.new.send(:something)
