covers 'facets/opendsl'

test_case OpenDSL do

  # `initialize` is exercised by every `OpenDSL.new`, and each scenario below
  # drives the block DSL (handled by #method_missing) end to end.
  method :initialize do

    test "defines a method on the module from a block" do
      example = OpenDSL.new do
        size do
          100
        end
      end
      klass = Class.new do include example end
      klass.new.size.assert == 100
    end

    test "defined methods receive their arguments" do
      example = OpenDSL.new do
        greet do |name|
          "hi #{name}"
        end
      end
      klass = Class.new do include example end
      klass.new.greet('bob').assert == 'hi bob'
    end

    test "an empty definition adds no methods" do
      example = OpenDSL.new
      example.instance_methods.assert == []
    end

    test "an unknown message without a block raises NoMethodError" do
      example = OpenDSL.new
      expect NoMethodError do
        example.no_such_thing
      end
    end

  end

end
