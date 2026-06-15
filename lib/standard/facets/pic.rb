# PIC - Pattern matching based on COBOL-style Edited Pictures.
#
# PIC provides a simple alternative to regular expressions for common
# data format matching. It uses single-character codes to describe the
# expected format of a string, inspired by COBOL's PICTURE clause.
#
# == Picture Characters
#
# The following picture characters are supported:
#
#   X - Any character (equivalent to regex `.`)
#   9 - Any digit (equivalent to regex `\d`)
#   Z - Zero or more digits (equivalent to regex `\d*`)
#   0 - Any digit (equivalent to regex `\d`)
#   A - Any letter, upper or lower case (equivalent to regex `[A-Za-z]`)
#   W - Any word character (equivalent to regex `\w`)
#   . - Literal period
#   , - Literal comma
#   - - Literal hyphen
#   / - Literal forward slash
#
# == Repetition
#
# Any picture character can be followed by a count in brackets:
#
#   9[3]       - Exactly 3 digits (e.g. `\d{3}`)
#   9[2,4]     - Between 2 and 4 digits (e.g. `\d{2,4}`)
#   9[2..4]    - Same as above, alternate syntax
#
# == Usage
#
#   require 'pic'
#
#   # Simple currency pattern
#   PIC['Z.99'].to_re        #=> /\d*\.\d\d/
#
#   # US phone number
#   PIC['9[3]-9[3]-9[4]'].to_re  #=> /\d{3}\-\d{3}\-\d{4}/
#
#   # Match against a string
#   PIC['99/99/9999'] =~ '12/25/2025'  #=> 0 (match)
#
# == Reference
#
# Based on the concept of Edited Pictures from COBOL.
# See: http://www.csis.ul.ie/cobol/course/EditedPics.htm
#
# Copyright (c) 2011 Rubyworks (BSD-2-Clause)
#
module PIC

  # Shortcut to `PIC::Template.new(pic)`.
  #
  # @param [String] pic
  #   A picture string describing the expected format.
  #
  # @return [PIC::Template]
  #
  # @example
  #   PIC['Z.99'].to_re  #=> /\d*\.\d\d/
  #
  def self.[](pic)
    Template.new(pic)
  end

  # Template class encapsulates a picture string, converts it to a
  # regular expression, and delegates to it for matching.
  #
  # @example
  #   t = PIC::Template.new('9[3]-9[3]-9[4]')
  #   t.to_re  #=> /\d{3}\-\d{3}\-\d{4}/
  #   t =~ '555-123-4567'  #=> 0
  #
  class Template

    # New pic template.
    #
    # @param [String] pic
    #   Picture string to use for matching.
    #
    def initialize(pic)
      @pic = pic
    end

    # The picture string.
    #
    # @return [String]
    #
    attr :pic

    # Convert picture to a regular expression.
    #
    # @return [Regexp]
    #
    # @example
    #   PIC::Template.new('99/99/9999').to_re  #=> /\d\d\/\d\d\/\d\d\d\d/
    #
    def to_re
      re = ''
      pic.scan(SCAN) do |s,c|
        re << remap(s) + recnt(c)
      end
      Regexp.new(re)
    end

    # Alias for `#to_re`.
    alias_method :to_regexp, :to_re

    # Match picture against a given string.
    #
    # @param [String] string
    #   String to match picture against.
    #
    # @return [Integer, nil] index position of match, or nil.
    #
    def =~(string)
      to_re =~ string.to_str
    end

    alias === =~

    # Check for non-match of the picture against a given string.
    #
    # @param [String] string
    #   String to match picture against.
    #
    # @return [Boolean]
    #
    def !~(string)
      to_re !~ string.to_str
    end

  private

    # Map a picture character to its regex equivalent.
    def remap(s)
      REMAP[s] || raise(ArgumentError, "unknown picture character: #{s}")
    end

    # Convert a bracket count to a regex quantifier.
    def recnt(c)
      return '' unless c

      case c
      when /\[(\d+)\.\.(\d+)\]/
        '{'+$1+','+$2+'}'
      when /\[(\d+)\,(\d+)\]/
        '{'+$1+','+$2+'}'
      when /\[(\d+)\]/
        '{'+$1+'}'
      end
    end

    # Scan pattern for parsing picture strings.
    SCAN = /(\S)(\[.*?\])?/

    # Mapping of picture characters to regex fragments.
    REMAP = {
      'X' => '.',
      '9' => '\d',
      'Z' => '\d*',
      '0' => '\d',
      'A' => '[A-Za-z]',
      'W' => '\w',
      '.' => '\.',
      ',' => '\,',
      '-' => '\-',
      '/' => '\/'
    }

  end

end
