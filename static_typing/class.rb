class Class
  def signature(*classes)
    metaclass = class << self; self; end
    metaclass.send :define_method, :method_added do |method|
      metaclass.send :remove_method, :method_added
      unbound_method = self.instance_method(method)
      define_method(method) do |*method_args|
        classes.each_with_index do |klass, index|
          unless method_args[index].is_a?(klass)
            raise ArgumentError, "expecting #{klass} for parameter #{index} of method #{method}"
          end
        end
        unbound_method.bind(self).call(*method_args)
      end
    end
  end
end
