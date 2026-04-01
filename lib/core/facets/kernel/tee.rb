require 'facets/functor'

module Kernel

  # Returns a Functor that intercepts method calls, forwards
  # them to self for side effects, and returns self. This is like
  # a block-less version of #tap that allows method chaining.
  #
  #   YAML.tee.load_file('foo.yml').load_file('bar.yml')
  #

  def tee
    Functor.new{ |op,*a,&b| self.send(op, *a, &b); self }
  end

end
