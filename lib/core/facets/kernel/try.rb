require 'facets/functor'

module Kernel

  # Invokes the method identified by the symbol +method+, passing it any
  # arguments and/or the block specified.
  #
  # Unlike regular send, a +NoMethodError+ exception will *not* be raised
  # if the receiving object is +nil+ (see NilClass#try below).
  #
  # Compatible with ActiveSupport's #try, plus an additional Tee/Functor
  # form when called with no arguments and no block.
  #
  #   @example.try(:name)              #=> "bob"
  #   @example.try { |o| o.name }     #=> "bob"  (ActiveSupport block form)
  #   @example.try.name               #=> "bob"  (Facets Tee form)
  #
  def try(method=nil, *args, &block)
    if method
      __send__(method, *args, &block)
    elsif block_given?
      yield self
    else
      self
    end
  end

  # Like #try, but raises NoMethodError if the method doesn't exist
  # (unless receiver is nil). Compatible with ActiveSupport's #try!.
  #
  def try!(method=nil, *args, &block)
    if method
      public_send(method, *args, &block)
    elsif block_given?
      yield self
    else
      self
    end
  end

end


class NilClass

  # See Kernel#try.
  def try(method=nil, *args, &block)
    if method
      nil
    elsif block_given?
      nil
    else
      Tee.new { nil }
    end
  end

  # See Kernel#try!.
  def try!(method=nil, *args, &block)
    if method
      nil
    elsif block_given?
      nil
    else
      Tee.new { nil }
    end
  end

end
