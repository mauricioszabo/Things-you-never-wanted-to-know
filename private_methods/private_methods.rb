module PrivateMethods
  def self.extended(klass)
    methods = {}
    caller_class = nil
    define_method :public_method do |method, &block|
      that = self
      #define_method(method) do |*args, &b|
      #  caller_class = that
      #  p self
      #  #instance_eval { |a, b| p a, b;  block.call *args, &b }
      #  instance_eval &block
      #end
      define_method(method, &block)
      bound_method = instance_method(method)
      define_method method do |*args, &b|
        caller_class = that
        bound_method.bind(self).call(*args, &b)
      end
    end

    define_method :private_method do |method, &block|
      methods[self] ||= {}
      methods[self][method] = block
      define_method method do |*args, &b|
        ret = if caller_class.nil?
          block.call(*args, &b)
        else
          methods[caller_class][method].call(*args, &b)
        end
        caller_class = nil
        ret
      end
    end
  end
end
