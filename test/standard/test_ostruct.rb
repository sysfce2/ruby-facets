covers 'facets/ostruct'

test_case OpenStruct do

  class_method :new do
    test "old functionality" do
      o = OpenStruct.new
      o.foo.assert.nil?
      o.foo = :bar
      o.foo.assert == :bar
      o.delete_field(:foo)
      o.foo.assert.nil?

      o1 = OpenStruct.new(:x => 1, :z => 2)
      o1.x.assert == 1
      o1.z.assert == 2

      o2 = OpenStruct.new(:x => 1, :z => 2)
      o1.assert == o2
    end

    test "via block" do
      person = OpenStruct.new do |p|
        p.name = 'John Smith'
        p.gender  = :M
        p.age     = 71
      end
      person.name.assert == 'John Smith'
      person.gender.assert == :M
      person.age.assert == 71
      person.address.assert == nil
    end

    test "via hash and block" do
      person = OpenStruct.new(:gender => :M, :age => 71) do |p|
        p.name = 'John Smith'
      end
      person.name.assert == 'John Smith'
      person.gender.assert == :M
      person.age.assert == 71
      person.address.assert == nil
    end
  end

end

test_case Hash do

  method :to_ostruct do

    test do
      a = { :a => 1, :b => 2, :c => 3 }
      ao = a.to_ostruct
      ao.a.assert == a[:a]
      ao.b.assert == a[:b]
      ao.c.assert == a[:c]
    end

  end

  method :to_ostruct_recurse do

    test do
      a = { :a => 1, :b => 2, :c => { :x => 4 } }
      ao = a.to_ostruct_recurse
      ao.a.assert == a[:a]
      ao.b.assert == a[:b]
      ao.c.x.assert == a[:c][:x]
    end

    test "with recursion" do
      a = {}
      a[:a] = a
      ao = a.to_ostruct_recurse
      ao.a.assert == ao
    end

  end

end
