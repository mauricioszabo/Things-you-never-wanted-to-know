require 'kernel'

describe Kernel do
  after do
    Object.send :remove_const, :Foo
  end

  it 'should be able to trace class creation out of a class' do
    $mock = mock('Object')
    Object.trace_class_creation do
      $mock.bar
    end
    class Foo
      $mock.should_receive(:bar)
    end
  end
end
