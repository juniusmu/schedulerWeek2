class Appointment
  attr_accessor :client, :service, :provider, :date, :start_time

  def initialize(client, service, provider,date, start_time)
    @client = client
    @service = service
    @provider = provider
    @date = date
    @start_time = start_time    
  end

  def equal(other)
    self.service == other.service && self.provider == other.provider && self.date == other.date && self.start_time == other.start_time 
  end
end