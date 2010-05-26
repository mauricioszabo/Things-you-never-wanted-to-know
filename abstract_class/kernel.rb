module Kernel
  def trace_class_creation(&block)
    classes_count = 0
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
