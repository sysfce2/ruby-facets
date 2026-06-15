module Math

  # The Kullback-Leibler divergence from distribution +p+ to distribution +q+.
  #
  # Both arrays must be the same size and represent probability distributions
  # (values should be positive).
  #
  # NB: You will possibly want to sort both P and Q before calling this
  # depending on what you're actually trying to measure.
  #
  # http://en.wikipedia.org/wiki/Kullback-Leibler_divergence
  #
  def self.kldivergence(p, q)
    raise ArgumentError, "Cannot compare differently sized arrays." unless p.size == q.size
    kld = 0.0
    p.each_with_index { |pi, i| kld += pi * Math.log(pi.to_f / q[i].to_f) }
    kld
  end

end
