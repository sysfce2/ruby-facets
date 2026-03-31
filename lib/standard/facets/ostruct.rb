require 'ostruct'
require 'facets/ostruct/initialize'
require 'facets/ostruct/merge'
require 'facets/ostruct/to_ostruct'

class OpenStruct

  # Non-destructive merge. Returns a new OpenStruct.
  #
  #   o = OpenStruct.new(a: 1)
  #   x = o.merge(b: 2)
  #   x.a  #=> 1
  #   x.b  #=> 2
  #
  def merge(other)
    dup.merge!(other)
  end

end
