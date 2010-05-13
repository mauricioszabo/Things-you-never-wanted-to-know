require 'singleton'
class Static
  include Singleton

  def method_missing(method, *args, &b)
    method = method.to_s
    variable = method.chop
    is_setter = method.end_with?("=")
    super unless is_setter and args.size == 1
    super unless b.nil?
    
    original_class = args[0].class
    self.class.send(:define_method, variable) { eval "@#{variable}" }
    self.class.send(:define_method, method) do |value|
      unless value.class.ancestors.include?(original_class)
        raise ArgumentError, "invalid type - expecting #{original_class}"
      end

      instance_variable_set(:"@#{variable}", value)
    end
    send method, args[0]
  end

  def inspect
  end
  alias :to_s :inspect
end

def static
  Static.instance
end
