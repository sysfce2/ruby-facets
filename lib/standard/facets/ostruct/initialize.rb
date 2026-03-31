require 'ostruct'

class OpenStruct

  # Allows the initialization of an OpenStruct with a setter block:
  #
  #   person = OpenStruct.new do |o|
  #     o.name    = 'John Smith'
  #     o.gender  = :M
  #     o.age     = 71
  #   end
  #
  # You can still provide a hash for initialization purposes, and even combine
  # the two approaches if you wish.
  #
  #   person = OpenStruct.new(:name => 'John Smith', :age => 31) do |p|
  #     p.gender = :M
  #   end
  #
  # CREDIT: Noah Gibbs, Gavin Sinclair
  def initialize(hash=nil, &block)
    @table = {}
    if hash
      hash.each_pair do |k, v|
        self[k.to_sym] = v
      end
    end
    if block && block.arity == 1
      yield self
    end
  end

end
