require 'static'

describe Static do
  it 'should be able to create a new method' do
    static.should_not respond_to(:variable)
    static.variable = 10
    static.should respond_to(:variable)
  end

  it 'should be able to set a value' do
    static.variable = 10
    static.variable.should be(10)
  end

  it 'should not be able to change the type of the variable' do
    static.variable = 10
    proc { static.variable = 'ten' }.should raise_error
  end
end
