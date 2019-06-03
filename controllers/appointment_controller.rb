require 'tty-prompt'
require 'date'
require_relative '../models/appointment'
require_relative './provider_controller'
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
      client = prompt.ask("Client name:")
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
      
      @appointment_candidate = Appointment.new(client, service, 
                                    provider, date, start_time)
      
      if check_availability
        @appointments << @appointment_candidate
        selected_provider = ProviderController.all.select { |provider| provider.name == @appointment_candidate.provider }[0]
        selected_provider.scheduled_appointments << @appointment_candidate

        puts "Appointment successfully scheduled for #{@appointment_candidate.client}:
        Service: #{@appointment_candidate.service}
        Provider: #{@appointment_candidate.provider}
        Date: #{@appointment_candidate.date}
        At: #{@appointment_candidate.start_time}:00
        ----------"
        puts "\n"
        continueProgram = false
      else
        puts "Your requested appointment is not available, please try a different request."
      end
    end
  end

  def self.check_availability
    key_of_day = @appointment_candidate.date.wday
    day_of_week = DaysOfWeek::DAY_OF_WEEK[key_of_day]
    provider_name = @appointment_candidate.provider
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
end
