class Pathname

  # @deprecated Use Pathname.new(File::NULL) instead.
  def self.null
    warn "Pathname.null is deprecated. Use Pathname.new(File::NULL) instead.", uplevel: 1
    new(File::NULL)
  end

end
