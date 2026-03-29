class String

  # Underscore a string such that camelcase, dashes and spaces are
  # replaced by underscores. This is the reverse of {#camelcase},
  # albeit not an exact inverse.
  #
  #   "SnakeCase".snakecase         #=> "snake_case"
  #   "Snake-Case".snakecase        #=> "snake_case"
  #   "Snake Case".snakecase        #=> "snake_case"
  #   "Snake  -  Case".snakecase    #=> "snake_case"
  #
  # Note, unlike #underscore this does not convert `::` to `/`.
  # Use {#pathize} for that, or use {#underscore} for ActiveSupport
  # compatible behavior.

  def snakecase
    gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
    gsub(/([a-z\d])([A-Z])/,'\1_\2').
    tr('-', '_').
    gsub(/\s/, '_').
    gsub(/__+/, '_').
    downcase
  end

  # Like #snakecase but also converts '::' to '/' for
  # namespace-to-path conversion. This is compatible with
  # ActiveSupport's #underscore.
  #
  #   "SnakeCase".underscore        #=> "snake_case"
  #   "Foo::Bar".underscore         #=> "foo/bar"
  #
  def underscore
    gsub(/::/, '/').snakecase
  end

  # TODO: Add *separators to #snakecase, like camelcase.

end
