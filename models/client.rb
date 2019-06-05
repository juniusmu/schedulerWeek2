class Client
	attr_accessor :id, :name, :appointments
	def initialize(id, name, appointments = [])
		@id = id
		@name = name
		@appointments = appointments
	end
end