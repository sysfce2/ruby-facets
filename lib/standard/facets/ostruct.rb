# Facets' extensions to Ruby's OpenStruct.
#
# NOTE: `ostruct` is deprecated as of Ruby 3.4 and is no longer a default gem
# as of Ruby 3.5 — it must be installed/declared explicitly to be available
# (`gem install ostruct`, or add `ostruct` to your Gemfile/gemspec). The gem
# itself still exists, so these extensions continue to work on top of it.
#
# Given OpenStruct's deprecation, Facets may divest these extensions in a
# future release.

require 'ostruct'
require 'facets/ostruct/initialize'
require 'facets/ostruct/to_ostruct'
