covers 'facets/object/dup'

test_case Object do
  setup "ordinary object" do
    @o = Object.new
  end

  method :dup? do
    test { assert @o.dup? }
  end

  method :clone? do
    test { assert @o.clone? }
  end
end

test_case TrueClass do
  method :dup? do
    test { refute true.dup? }
  end

  method :clone? do
    test { refute true.clone? }
  end
end

test_case FalseClass do
  method :dup? do
    test { refute false.dup? }
  end

  method :clone? do
    test { refute false.clone? }
  end
end

test_case NilClass do
  method :dup? do
    test { refute nil.dup? }
  end

  method :clone? do
    test { refute nil.clone? }
  end
end

test_case Symbol do
  method :dup? do
    test { refute :a.dup? }
  end

  method :clone? do
    test { refute :a.clone? }
  end
end

test_case Numeric do
  method :dup? do
    test { refute 1.dup? }
  end

  method :clone? do
    test { refute 1.clone? }
  end
end
