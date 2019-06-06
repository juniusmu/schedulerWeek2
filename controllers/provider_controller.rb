require 'tty-prompt'
require 'date'
require_relative '../models/provider'
require_relative '../models/service'
require_relative '../utilities'
include DaysOfWeek

class ProviderController
  attr_accessor :providers
   @providers = []
#  @providers = [Provider.new('Junius', '234-486-9800', @service_types),     
#                Provider.new('Pearl', '978-123-5768', @service_types),
#                Provider.new('Rifty', '008-111-2590', @service_types)]

  @available_days = []
  def self.all
    @providers
  end

  def self.index
    puts "Here's the current list of providers:"

    @providers.map do |provider|
      puts "#{provider.name}'s phone number is #{provider.phone_number}."
      puts "(S)he provides these services: #{provider.services} every day of the week except for:"
      provider.days_off.each do |day|
	      puts day 
      end
      puts "––––––––––"
    end
  end

  def self.add
    prompt = TTY::Prompt.new(interrupt: :exit)

    name = prompt.ask('Provider Name:')
    phone_number = prompt.ask('Phone number:')
    service_types = $service_list.map { |service| service.name}
    choices = service_types
    services = prompt.multi_select("Please choose services from the 
                following list:", choices)
    days_off = prompt.multi_select('Days off:', ['Monday', 'Tuesday', 'Wednesday', 
                'Thursday', 'Friday', 'Saturday', 'Sunday'])
    success = add_provider(name, phone_number, services, days_off)
  end

  def self.remove
    prompt = TTY::Prompt.new(interrupt: :exit)
    options = @providers.map { |provider| provider.name}
    choice = prompt.select("Pick a provider to remove", options)

    @providers = @providers.reject { |provider| provider.name == choice}
  end


  def self.add_availability
	prompt = TTY::Prompt.new(interrupt: :exit)
	all_names = []
	@providers.each { |provider| all_names << provider.name}

	provider_name = prompt.select("Which provider's schedule would you like to see?", all_names)

	selected_provider = @providers.select { |provider| provider.name == provider_name}[0]

	

  end
  #TODO: abstract the puts into something that's in control of input and output
  def self.view_schedule
    prompt = TTY::Prompt.new(interrupt: :exit)
    all_names = []
    @providers.each { |provider| all_names << provider.name}

    provider_name = prompt.select("Which provider's schedule would you like to see?", all_names)

    selected_provider = @providers.select { |provider| provider.name == provider_name}[0]

    puts "----------\n"
    puts "Below are the appointments on #{selected_provider.name}'s calendar:"
    selected_provider.scheduled_appointments.map do |appt|
      puts "Client name: #{appt.client}
      Service: #{appt.service}
      Daste: #{appt.date}
      Start time: #{appt.start_time}
      "
    end
    puts "----------\n"
  end

  def self.add_provider(name, phone_number, services, days_off)
	  dates_off = []
	days_off.each do |day|
		first_date_of_day = DaysOfWeek::FIRST_DATE_OF_DAY_IN_2020[day]
		puts first_date_of_day
		date = Date.new(2020, 1, first_date_of_day)
		loop do
			if date.year > 2020
				break
			end
			dates_off << date
			date = date + 7
		end

	end
	dates_off.each do |day|
		puts day
	end
	provider = Provider.new(name, phone_number, services, dates_off)
	@providers << provider
	puts "\n"
	puts "#{provider.name} is successfully added."
	puts "\n"
	puts self.index
  end
end
