require 'tty-prompt'
require 'date'
require_relative '../models/appointment'
require_relative './provider_controller'
require_relative './client_controller'
require_relative '../utilities'

class AppointmentController
  attr_accessor :appointment_candidate, :appointments

  @appointments = []

  def self.all
    @appointments
  end

  def self.index
    @appointments.map do |appointment|
      puts "Client: #{appointment.client}"
      puts "Service: #{appointment.service}"
      puts "Provider: #{appointment.provider}"
      puts "Date: #{appointment.date}"
      puts "At: #{appointment.start_time}:00"
    end
  end

  def self.add
    continueProgram = true
    prompt = TTY::Prompt.new(interrupt: :exit)


    while continueProgram do
      client_response = prompt.select("Are you a new client?") do |q|
        q.choice name: 'New Client', value: true
        q.choice name: 'Existing Client', value: false
      end

      if client_response
        # add new client
      else
        client = prompt.select("Select the client:", ClientController.all
                                                      .map{|c| c.name})
      end

      service = prompt.select('Service wanted:', 
                ['Mind Reading', 'Demonic Exorcism', 
                'Potion Therapy', 'Liver Transplants'])
      provider = prompt.select("Please select from these providers:",   
                  ProviderController.all
                    .select do |provider| 
                      provider.services.include?(service)
                    end.map(&:name)
                  )
      month = prompt.ask("What month in 2020 would you like to have the appointment?")
      day = prompt.ask("What day of the month would you like to have the appointment?")
      date = Date.new(2020,month.to_i,day.to_i)
      start_time = prompt.ask("What time would you like to start the appointment?")

      client_object = (ClientController.all.select{|client_name| client_name.name == client})[0]
      provider_object = (ProviderController.all.select{|provider_name| provider_name.name == provider})[0]

      success = add_appointment(client_object, service, provider_object, date, start_time)

      if success
        puts "Appointment successfully scheduled for #{client}:"

        print

        continueProgram = false
      else
        puts "Your requested appointment is not available, please try a different request."
      end
    end
  end

  def self.remove
    # continueProgram = true
    prompt = TTY::Prompt.new(interrupt: :exit)

    # choose provider
    provider = prompt.select("Please select the provider:", ProviderController.all
                                                                      .map{|p| p.name})

    provider_object = (ProviderController.all.select{|provider_name| provider_name.name == provider})[0]
    # choose the name of the client
    provider_clients = provider_object.scheduled_appointments.map{|pc| pc.name}

    # puts provider_clients.class


    client = prompt.select("Choose the client:", provider_clients)

    # month = 
   
    # list appointments
    # client_appointments = @appointments.map{|ca| ca.provider.name = provider.name}
    # client_appointments.each{print}

    # puts client_appointments.first.name

    # choose an appointment from the provider
    # client_appointment_delete = prompt.select("Select the clients appointment to delete:", client_appointments.map{|c| c.name})
    # are you sure?
    # delete

  end

  def self.check_availability
    key_of_day = @appointment_candidate.date.wday
    day_of_week = DaysOfWeek::DAY_OF_WEEK[key_of_day]
    provider_name = @appointment_candidate.provider.name
    provider_days_off = ProviderController.all.find { |provider| provider.name == provider_name}.days_off
    
    return false if provider_days_off.include?(day_of_week) 
    return false if conflict?
    true
  end

  def self.conflict?
    check_equal = @appointments.map do |appointment|
      @appointment_candidate.equal(appointment)
    end

    check_equal.include?(true)
  end

  def self.print
    puts "
    Client: #{@appointment_candidate.client.name}
    Service: #{@appointment_candidate.service}
    Provider: #{@appointment_candidate.provider.name}
    Date: #{@appointment_candidate.date}
    At: #{@appointment_candidate.start_time}:00
    ----------"
    puts "\n"
  end

  private

  def self.add_appointment(client, service, provider, date, start_time)
    @appointment_candidate = Appointment.new(client, service, provider, date, start_time)
    

    if check_availability
      selected_provider = ProviderController.all.select { |p| p.name == provider.name }[0]

      @appointments << @appointment_candidate
      selected_provider.scheduled_appointments << @appointment_candidate

      return true
    else 
      return false
    end
  end

  def self.remove_appointment(client, service, date, start_time)
    @appointment_delete = AppointmentController.all.select {|a| a.client == client && a.service == service && a.date == date && a.start_time == start_time}
  end
    
end
