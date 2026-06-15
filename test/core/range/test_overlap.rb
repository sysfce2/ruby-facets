covers 'facets/range/overlap'

test_case Range do

  method :overlap? do

    test "true when two ranges share elements" do
      (1..5).overlap?(3..8).assert == true
    end

    test "false when two ranges are disjoint" do
      (1..5).overlap?(6..8).assert == false
    end

    test "true when ranges touch at a boundary" do
      (1..5).overlap?(5..9).assert == true
    end

    test "true when one range contains the other" do
      (1..10).overlap?(3..5).assert == true
    end

  end

end
