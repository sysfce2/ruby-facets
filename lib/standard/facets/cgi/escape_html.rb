require 'cgi'

class CGI

  # Extended HTML/XHTML escaping with mode support. Unlike Ruby's built-in
  # `CGI.escape_html`, this supports additional escape modes.
  #
  # Available modes:
  # * `:quote`     - escapes single and double quotes
  # * `:newlines`  - escapes newline characters (\r and \n)
  # * `:ampersand` - escapes the ampersand sign
  # * `:brackets`  - escapes less-than and greater-than signs
  # * `:default`   - escapes double quotes
  #
  # By default all strings are escaped on `&`, `>`, `<` and `"`.
  #
  # @example
  #   CGI.escape_xhtml("<tag>")  #=> "&lt;tag&gt;"
  #   CGI.escape_xhtml("Example\nString", :newlines)  #=> "Example&#13;&#10;String"
  #   CGI.escape_xhtml("\"QUOTE\"", false)  #=> "\"QUOTE\""
  #
  def self.escape_xhtml(string, *modes)
    modes << :default if modes.empty?

    unless modes.include?(:nonstandard)
      string = string.gsub(/&/, '&amp;').gsub(/>/, '&gt;').gsub(/</, '&lt;')
    end

    modes.each do |mode|
      string = \
        case mode
        when :quote, :quotes
          string.gsub(%r|"|,'&quot;').gsub(%r|'|,'&#39;')
        when :newlines
          string.gsub(/[\r\n]+/,'&#13;&#10;')
        when :ampersand
          string.gsub(/&/, '&amp;')
        when :bracket, :brackets
          string.gsub(/>/, '&gt;').gsub(/</, '&lt;')
        when :default, true
          string.gsub(/\"/, '&quot;')
        when false
          string
        else
          raise ArgumentError, "unrecognized HTML escape mode -- #{mode}"
        end
    end

    string
  end

end
