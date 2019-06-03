class Provider
  attr_accessor :name, :phone_number, :services, :days_off, :scheduled_appointments

  def initialize(name, phone_number, services=[], days_off=[], scheduled_appointments=[])
      @name = name
      @phone_number = phone_number
      @services = services
      @days_off = days_off
      @scheduled_appointments = scheduled_appointments
  end
end
 
