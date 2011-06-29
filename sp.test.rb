require 'test/unit'
require 'sp'

class TestThing < Thing
	attr_reader :integrals, :the_thing
end

class TC_spTest < Test::Unit::TestCase

	def setup
		@parent = TestThing.new '', 10, 0
		@child = TestThing.new '', 0, 5
		@parent.plug @child
	end
	
	def test_activate
		assert @child.activate
	end
	
	def test_active?
		assert @parent.active?
		assert !@child.active?
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
		assert_equal 5, @child.energy_required
	end

end
