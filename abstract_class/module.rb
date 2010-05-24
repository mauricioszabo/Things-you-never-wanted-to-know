class Module
  def trace_class_creation(inside_class = 1, &block)
    classes_count = inside_class
    procedure = proc do |event, file, line, id, binding, classname|
      classes_count += 1 if event == 'class'
      classes_count -= 1 if event == 'end'
      if event == 'end' && classes_count == 0
        set_trace_func nil
        block.call
      end
    end
    set_trace_func procedure
  end
end
