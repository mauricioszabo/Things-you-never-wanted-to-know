require "private_methods"

class Example
  extend PrivateMethods

  private_method :saying do
    "Foo"
  end

  public_method :say do
    saying + " Bar"
  end
end

class Ex2 < Example
  private_method :saying do
    "Example 2"
  end

  public_method :say_two do
    saying
  end
end

class Ex3 < Ex2
  public_method :say_three do
    saying
  end
end

class Ex4 < Example
  private_method :saying do
    'Example 4'
  end

  public_method :say do
    saying
  end
end

class Ex5 < Example
  public_method :say_five do
    saying
  end
end

describe 'Private Method Crash' do
  it 'should not override the superclass private method' do
    Ex2.new.say.should == "Foo Bar"
    Ex3.new.say.should == 'Foo Bar'
  end

  it 'should use the child class private method if caller is on the child class' do
    Ex2.new.say_two.should == 'Example 2'
  end

  it 'should be able to override private methods if callee is on the new class' do
    Ex4.new.say.should == 'Example 4'
  end

  it 'should be able to call parents private methods' do
    Ex3.new.say_three.should == 'Example 2'
    Ex5.new.say_five.should == 'Foo'
  end
end
