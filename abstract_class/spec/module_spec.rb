require 'module'

describe Module do
  after do
    Object.send :remove_const, :Foo
  end

  it 'should be able to trace class creation' do
    $mock = mock('Object')
    class Foo
      trace_class_creation do
        $mock.foo
      end
      $mock.should_receive(:foo)
    end
  end

  it 'should be able to trace class creation out of a class' do
    $mock = mock('Object')
    Object.trace_class_creation 0 do
      $mock.bar
    end
    class Foo
      $mock.should_receive(:bar)
    end
  end
end
