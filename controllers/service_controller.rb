require 'tty-prompt'
require_relative '../models/service'

class ServiceController
  attr_accessor :services

  @services = [Service.new('Hair cut', 20, 1), 
              Service.new('Massage', 50, 2),
              Service.new('Makeup', 100, 2)]

  def self.all
    @services
  end

  def self.index
    puts "Here's the current list of services:"
    
    @services.map do |service|
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
    @services << service

    puts "\n"
    puts "#{service.name} is successfully added."
    puts "\n"
    puts self.index
  end

  def self.remove
    prompt = TTY::Prompt.new(interrupt: :exit)
    options = @services.map { |service| service.name}
    choice = prompt.select("Pick a service to delete", options)
    
    @services = @services.delete_if { |service| service.name == choice }

    puts "\n"
    puts "#{choice} is successfully removed."
    puts "\n"
    puts self.index
  end
end
