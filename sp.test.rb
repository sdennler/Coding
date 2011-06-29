require 'test/unit'
require 'sp'

class TestThing < Thing
	attr_reader :integrals
end

class TC_spTest < Test::Unit::TestCase

	def setup
		@parent = TestThing.new
		@child = TestThing.new
		@parent.plug $child
	end
	
	def test_plug
		assert_equal @child, @parent.integrals[0]
	end

	def test_energy
		
	end

end
