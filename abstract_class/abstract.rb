module Abstract
  def self.included(included_class)
    classes = ['', 'Abstract', included_class.name]
    procedure = proc do |event, file, line, id, binding, classname|
      klass = eval('self', binding).name rescue nil
      #p eval('self', binding)
      unless classes.include?(klass)
        set_trace_func nil
        @@abstract_classes ||= {}
        methods = included_class.public_instance_methods(false)
        methods += included_class.private_instance_methods(false)
        methods += included_class.protected_instance_methods(false)
        @@abstract_classes[included_class.name] = methods
        p @@abstract_classes
      end
    end
    set_trace_func procedure
  end
end

