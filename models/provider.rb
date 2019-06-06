class Provider
  attr_accessor :name, :phone_number, :services, :available_days, :scheduled_appointments

  def initialize(name, phone_number, services=[], available_days = Set[], scheduled_appointments=[])
	@name = name
	@phone_number = phone_number
	@services = services
	@available_days = available_days
	@scheduled_appointments = scheduled_appointments
  end
end
 
