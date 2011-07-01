class Thing
	attr_reader :name, :structure, :energy_required

	def initialize(name = '', energy = 0, energy_required = 1)
		@name = name
		@structure = 100
		@energy = energy
		@energy_required = energy_required
		@the_thing = nil
		@integrals = []
		setup
	end
	def setup
	end

	def plug integral
		@integrals << integral if integral.wire(self)
	end

	def wire to_thing
		@the_thing = to_thing
	end

	def activate
		@integrals.sort! {|x,| x.kind_of?(EnergySupply) ? -1 : 1}
		@integrals.each {|i| i.activate}
		if (@energy_required != @energy) and @the_thing.kind_of?(Thing)
			@energy += @the_thing.energy(@energy - @energy_required)
		end
		ready?
	end

	def ready?
		return false unless @energy >= @energy_required
		@integrals.collect {|i| return false unless i.ready?}.compact.inspect
		true
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

	alias in inspect
	def inspect(data = :all, nested = '')
		return super if data == :super
		d  = "#{self.class} "
		d += "#{@name} " unless @name.empty?
		d += "(S#{@structure} E#{@energy}/#{@energy_required})"
		nested += ' '
		if data != :base
			i = @integrals.collect {|i| i.inspect(data, nested)}.join("\n"+nested)
			d += "\n" + nested + i unless i == ''
		end
		d
	end
	alias i inspect

	def attr attr
		#self.call('@'+attr.to_s)
	end
end 

class Ship < Thing
end

class Part < Thing
end

class EnergySupply < Part
	def setup
		@energy = 10
		@energy_require = (@energy.to_f/10).ceil
	end
end

class Gun < Part
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
		%w(Gun Shield EnergySupply).each {|c|
			e = nil
			eval "e = #{c}.new @count.to_s"
			ship.plug e
			p << e
		}
		@p << p
		ship
	end
end
