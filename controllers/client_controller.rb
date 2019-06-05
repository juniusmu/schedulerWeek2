#TODO tty stuff
#TODO set client

require 'tty-prompt'
require_relative '../models/client'

class ClientController
    attr_accessor :clients

    @clients = [Client.new(0, 'Vlad', [Appointment.new('Bob', 'Test Service 1', 'Test', Date.new(2020,1,1), 12)]),
                Client.new(1, 'Eddie', [Appointment.new('Bobby', 'Test Service 1', 'Test', Date.new(2020,2,1), 12)])]

    def self.all
        @clients
    end

    def self.add
    
    end
end