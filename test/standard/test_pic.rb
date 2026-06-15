covers 'facets/pic'

test_case PIC do

  class_method :[] do
    test "returns a Template" do
      PIC['Z.99'].class.assert == PIC::Template
    end
  end

end

test_case PIC::Template do

  method :to_re do
    test "maps picture characters to a regular expression" do
      PIC::Template.new('Z.99').to_re.assert == /\d*\.\d\d/
    end

    test "applies exact bracket counts" do
      PIC::Template.new('9[3]-9[3]-9[4]').to_re.assert == /\d{3}\-\d{3}\-\d{4}/
    end

    test "applies range bracket counts in both syntaxes" do
      PIC::Template.new('9[2..4]').to_re.assert == /\d{2,4}/
      PIC::Template.new('9[2,4]').to_re.assert == /\d{2,4}/
    end

    test "raises on an unknown picture character" do
      expect ArgumentError do
        PIC::Template.new('Q').to_re
      end
    end
  end

  method :=~ do
    test "returns the match index on a match" do
      (PIC['99/99/9999'] =~ '12/25/2025').assert == 0
    end

    test "returns nil on no match" do
      (PIC['A'] =~ '7').assert == nil
    end
  end

  method :!~ do
    test "returns true when the picture does not match" do
      (PIC['9'] !~ 'x').assert == true
    end
  end

end
