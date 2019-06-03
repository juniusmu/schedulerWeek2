class Client
	attr_accessor :name, :appointments
	def initialize(name, appointments = [])
		@name = name
		@appointments = appointments
	end
end