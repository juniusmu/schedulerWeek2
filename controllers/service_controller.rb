require 'tty-prompt'
require_relative '../models/service'
require_relative '../seed'

class ServiceController

  def self.all
    @services
  end

  def self.index
    puts "Here's the current list of services:"
    
    $service_list.map do |service|
      puts "#{service.name} costs $#{service.price}, and takes about #{service.duration} hours."
      puts "––––––––––"
    end
  end

  def self.add
    prompt = TTY::Prompt.new(interrupt: :exit)
    name = prompt.ask('Name:')
    price = prompt.ask('Price($):')
    duration = prompt.ask('Duration(hours):')
    
    service = Service.new(name, price, duration)
    $service_list << service

    puts "\n"
    puts "#{service.name} is successfully added."
    puts "\n"
    puts self.index
  end

  def self.add_service(name, price, duration)
    service = Service.new(name, price, duration)
    $service_list << service
  end

  def self.remove
    prompt = TTY::Prompt.new(interrupt: :exit)
    options = @services.map { |service| service.name}
    choice = prompt.select("Pick a service to delete", options)
    
    $service_list = @services.delete_if { |service| service.name == choice }

    puts "\n"
    puts "#{choice} is successfully removed."
    puts "\n"
    puts self.index
  end
  def self.remove_service(service_name)

	$service_list = $service_list.delete_if { |service| service.name == service_name }
  end
end
