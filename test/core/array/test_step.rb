covers 'facets/array/step.rb'

test_case Array do

  method :step do

    test "iteration" do
      a = [:a, :b, :c, :d]
      r = []

      a.step(2){ |e| r << e }

      r.assert == [:a, :c]
    end

    test "conversion to array" do
      a = [:a, :b, :c, :d]
      a.step(1).to_a.assert == [:a, :b, :c, :d]
      a.step(2).to_a.assert == [:a, :c]
      a.step(3).to_a.assert == [:a, :d]
      a.step(5).to_a.assert == [:a]
    end

    test "with offset" do
      a = [:a, :b, :c, :d, :e, :f]
      a.step(2, 1).to_a.assert == [:b, :d, :f]
    end

  end

end
