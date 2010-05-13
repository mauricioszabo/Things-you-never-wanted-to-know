require 'class'

describe Class do
  after do
    Object.send :remove_const, :Foo
  end

  it 'should be able to add a "signature" to the method' do
    class Foo
      signature String, Fixnum
      def a_method(a_string, a_fixnum)
      end
    end
  end

  it 'should be able to obey the signature' do
    class Foo
      signature String, Fixnum
      def a_method(a_string, a_fixnum)
        "#{a_string} = #{a_fixnum}"
      end
    end

    foo = Foo.new
    foo.a_method('me', 10).should == 'me = 10'
    proc { foo.a_method(10, 20) }.should raise_error
    proc { foo.a_method('me', 'foo') }.should raise_error
  end

  it 'should not add a signature if is not explicity declared' do
    class Foo
      signature String, Fixnum
      def a_method(a_string, a_fixnum)
      end

      def another_method(foo, bar)
      end
    end
    foo = Foo.new
    proc { foo.another_method(10, "number") }.should_not raise_error
  end
end
