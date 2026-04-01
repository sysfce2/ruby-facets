# @deprecated Use deep_dup/deep_clone instead, or define your own
#   initialize_copy method.
warn "facets/cloneable is deprecated. Use deep_dup/deep_clone instead.", uplevel: 1

module Cloneable

  def initialize_copy(sibling)
    super
    operation = (
      copy_call  = caller.find{|x| x !~ /'initialize_copy'/}
      copy_match = copy_call.match(/`(dup|clone)'/)
      copy_match ? copy_match[1] : :dup
    )
    sibling.instance_variables.each do |ivar|
      value = sibling.instance_variable_get(ivar)
      instance_variable_set(ivar, value.send(operation))
    end
  end

end
