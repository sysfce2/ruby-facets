require 'facets/binding/callstack'

class Binding

  # Returns the call stack, same format as Kernel#caller()
  #
  # Accepts the same `(start, length)` arguments as Kernel#caller.
  #
  def caller( start=0, length=nil )
    length ? eval("caller(#{start}, #{length})") : eval("caller(#{start})")
  end

  # Returns the call stack, same format as Kernel#caller_locations()
  #
  # Accepts the same `(start, length)` arguments as Kernel#caller_locations.
  #
  def caller_locations( start=0, length=nil )
    length ? eval("caller_locations(#{start}, #{length})") : eval("caller_locations(#{start})")
  end

  # Return the line number on which the binding was created.
  #
  def __LINE__
    self.source_location[1]
  end

  # Returns file name in which the binding was created.
  #
  def __FILE__
    self.source_location[0]
  end

  # Return the directory of the file in which the binding was created.
  #
  def __DIR__  
    File.dirname(self.__FILE__)
  end

  # Retreive the current running method.
  #
  def __method__
    Kernel.eval("__method__", self)
  end

  # Retreive the current running method.
  #
  def __callee__
    Kernel.eval("__callee__", self)
  end

end

