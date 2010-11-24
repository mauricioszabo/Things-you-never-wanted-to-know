module PrivateMethods
  def self.extended(klass)
    defined_methods = {}
    caller_class = nil
    define_method :public_method do |method, &block|
      that = self
      define_method(method, &block)
      bound_method = instance_method(method)
      define_method method do |*args, &b|
        caller_class = that
        bound_method.bind(self).call(*args, &b)
      end
    end

    define_method :private_method do |method, &block|
      define_method method, &block
      im = instance_method method
      defined_methods[self] ||= {}
      defined_methods[self][method] = im
      define_method method do |*args, &b|
        ret = if defined_methods[caller_class].nil? || defined_methods[caller_class][method].nil?
          im.bind(self).call(*args, &b)
        else
         defined_methods[caller_class][method].bind(self).call(*args, &b)
        end
        caller_class = nil
        ret
      end
      private method
    end
  end
end
