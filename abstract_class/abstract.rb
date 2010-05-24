require 'module'

module Abstract
  def self.abstract_classes
    @abstract_classes ||= {}
  end

  def self.included(included_class)
    methods = []
    trace_class_creation do
      methods += included_class.public_instance_methods(false)
      methods += included_class.private_instance_methods(false)
      methods += included_class.protected_instance_methods(false)
    end

    abstract_classes = @abstract_classes
    metaclass = class << included_class; self; end
    metaclass.send :define_method, :inherited do |inherited_class|
      trace_class_creation 0 do
        my_methods = inherited_class.public_instance_methods(false)
        my_methods += inherited_class.private_instance_methods(false)
        my_methods += inherited_class.protected_instance_methods(false)

        methods.each do |m|
          raise "Method #{m} not implemented." unless my_methods.include?(m)
        end
      end
    end
  end
end

