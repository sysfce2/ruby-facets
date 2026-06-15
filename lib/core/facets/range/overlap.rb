class Range

  # Do two ranges overlap?
  #
  #   (1..5).overlap?(3..8)   #=> true
  #   (1..5).overlap?(6..8)   #=> false
  #
  # Ruby 3.3 added a native Range#overlap?, so only define Facets' version
  # on older Rubies that lack it -- this avoids replacing the built-in.
  #
  # CREDIT: Daniel Schierbeck, Brandon Keepers

  unless method_defined?(:overlap?)
    def overlap?(other)
      include?(other.first) or other.include?(first)
    end
  end

end
