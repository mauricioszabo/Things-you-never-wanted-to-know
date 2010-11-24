require "private_methods"

class SelfExample
  extend PrivateMethods

  public_method :myself do
    self
  end

  public_method :private_self do
    ret_private_self
  end

  private_methods :ret_private_self do
    self
  end
end

describe 'Self on methods' do
  it 'should correct the "self" on public methods' do
    SelfExample.new.myself.should be_a(SelfExample)
  end
end
