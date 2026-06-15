require 'ae'

# Regression guard for the 3.2.0 load failures (issues #312, #315): method
# files were removed or renamed, but stale `require_relative` lines were left
# behind, so `require 'facets'` raised LoadError. This verifies that every
# `require_relative` target across the library resolves to a real file, so the
# whole class of breakage can't recur unnoticed.
#
# This is a Rubytest-native test rather than a Lemon unit test: Lemon targets
# individual methods for coverage, which doesn't fit a library-wide invariant.
# Rubytest's universal harness runs any object on $TEST_SUITE that responds to
# #call/#each and #to_s. See https://rubyworks.github.io/rubytest.

module FacetsLoadPaths

  LIB_DIR = File.expand_path('../../lib', __dir__)

  # Return a list of "file:line -> target" for every `require_relative` whose
  # target file does not exist. Empty list means all load paths resolve.
  def self.unresolved_requires
    missing = []
    Dir.glob(File.join(LIB_DIR, '**', '*.rb')).sort.each do |file|
      dir = File.dirname(file)
      File.foreach(file).with_index do |line, i|
        next if line =~ /^\s*#/                       # skip commented-out requires
        next unless line =~ /^\s*require_relative\s+["']([^"']+)["']/
        target = $1
        candidate = target.end_with?('.rb') ? target : "#{target}.rb"
        unless File.exist?(File.expand_path(candidate, dir))
          missing << "#{file.sub("#{LIB_DIR}/", '')}:#{i + 1} -> #{target}"
        end
      end
    end
    missing
  end

  # A single Rubytest-compliant test procedure. It must respond to #call and
  # #to_s but NOT #each (a #each-responding object is treated as a case, not a
  # test) -- so this is a plain class, not a Struct.
  class Check
    def initialize(description, &body)
      @description = description
      @body = body
    end

    def to_s
      @description
    end

    def call
      @body.call
    end
  end

  # A Rubytest-compliant test case (responds to #each and #to_s).
  class Case
    def to_s
      'Facets load paths'
    end

    def each
      yield Check.new('every require_relative target resolves to an existing file') {
        FacetsLoadPaths.unresolved_requires.assert == []
        true
      }
    end
  end

end

($TEST_SUITE ||= []) << FacetsLoadPaths::Case.new
