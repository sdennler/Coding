class Thing

	def initialize(name = '')
		@name = name
		@structure = 100
		@energy = 0
		@the_thing = nil
		@integrals = []
	end

	def plug integral
		@integrals << integral if integral.wire(self)
	end

	def wire to_thing
		@the_thing = to_thing
		aktivate
		true
	end
	
	def aktivate
	end

	def working?
		@energy >= 0
	end
	
	alias inspect to_s
	def inspect(data = :base)
		d  = "#{self.class} "
		d += "#{@name} " unless @name.empty?
		d += "(S#{@structure} E#{@energy})"
		d += "\n "+@integrals.collect {|i| i.inspect}.join(', ') unless data == :base
		d
	end
end 

class Part < Thing
end

class Ship < Part
end

class EnergySupply < Part
end

class Gun < Part
	@energy = -2
end

class Shield < Part
end
 
class D
	
	@p = []
	@count = 0

	def D.p
		@p
	end
	
	def D.s
		@p.each {|p| puts p[0].inspect :full}
		return
	end

	def D.b
		@count += 1
		p = []
		ship = Ship.new('S'+@count.to_s)
		p << ship
		%w(EnergySupply Gun Shield).each {|c|
			e = nil
			eval "e = #{c}.new @count.to_s"
			ship.plug e
			p << e
		}
		@p << p
		ship
	end
end
