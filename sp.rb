class Thing
	attr_reader :name, :structure, :energy, :energy_required
	
	def initialize(name = '', energy = 0, energy_required = 1)
		@name = name
		@structure = 100
		@energy = energy
		@energy_required = energy_required
		@the_thing = nil
		@integrals = []
	end

	def plug integral
		@integrals << integral if integral.wire(self)
	end

	def wire to_thing
		@the_thing = to_thing
		true
	end
	
	def activate
		if @energy_required > @energy
			@energy = @the_thing.energy(@energy_required - @energy) if @the_thing.kind_of? Part
		end
		active?
	end

	def active?
		@energy >= @energy_required
	end

	def energy mod = nil
		if mod === nil
			@energy
		elsif (mod > 0) or (mod.abs <= @energy) then
			@energy += mod
			mod * -1
		else
			0
		end
	end
		
	alias inspect to_s
	def inspect(data = :base)
		d  = "#{self.class} "
		d += "#{@name} " unless @name.empty?
		d += "(S#{@structure} E#{@energy})"
		d += "\n "+@integrals.collect {|i| i.inspect}.join(', ') unless data == :base
		d
	end

	def attr attr
		#self.call('@'+attr.to_s)
	end
end 

class Ship < Thing
end

class Part < Thing
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
