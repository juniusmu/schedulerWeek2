#TODO tty stuff
#TODO set client

require 'tty-prompt'
require_relative '../models/client'

class ClientController
    attr_accessor :clients

    @clients = [Client.new(0, 'Vlad', []),
                Client.new(1, 'Eddie', [])]

    def self.all
        @clients
    end

    def self.add
    
    end
end