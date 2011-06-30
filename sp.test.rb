require 'test/unit'
require 'sp'

class TestThing < Thing
	attr_reader :integrals, :the_thing
end
class MockTestThing < TestThing
	@@calls = Hash.new(0)
	def MockTestThing.calls method
		@@calls[method]
	end
	def activate
		@@calls[:activate] += 1
	end
end

class TC_spTest < Test::Unit::TestCase

	def setup
		@parent = TestThing.new 'Parent 1', 10, 0
		@child = TestThing.new 'Child 1', 0, 4
		@parent.plug @child
	end
	
	def test_activate_activate_integrals
		2.times {@parent.plug MockTestThing.new}
		@parent.activate
		assert_equal 2, MockTestThing.calls(:activate)
	end	
	
	def test_activate_energy_drain
		assert @child.activate
		assert_equal 6, @parent.energy
		assert_equal 4, @child.energy
	end
	
	def test_ready?
		assert !TestThing.new('', 0, 5).ready?
		parent = MockTestThing.new 'mock', 5, 2
		assert parent.ready?
		parent.plug MockTestThing.new('mockchild 1', 1, 1)
		assert parent.ready?
		parent.plug MockTestThing.new('mockchild 2', 0, 1)
		assert !parent.ready?
	end
	
	def test_wire
		child = TestThing.new
		assert child.wire(@parent)
		assert_equal @parent, child.the_thing
	end
	
	def test_energy
		assert_equal 1, @parent.energy(-1)
		assert_equal 9, @parent.energy
		assert_equal -2, @parent.energy(2)
		assert_equal 11, @parent.energy
		assert_equal 0, @parent.energy(-12)
		assert_equal 11, @parent.energy
	end
	
	def test_plug
		assert_equal @child, @parent.integrals[0]
		assert_equal @parent, @child.the_thing
		assert_nil @parent.the_thing
	end
	
	def test_initialize
		assert_equal 10, @parent.energy
		assert_equal 0, @parent.energy_required
		assert_equal 0, @child.energy
		assert_equal 4, @child.energy_required
	end
	
end
