require 'abstract'

class AbstractClass
  include Abstract

  def foo
  end
end

describe Abstract do
  it 'should complain if I try to create a class without all the methods' do
    proc do
      class Another < AbstractClass
      end
    end.should raise_error(NoMethodError)
  end

  it 'should not complain if I try to create a class with all the methods' do
    class Another < AbstractClass
      def foo
      end
    end
  end
end
