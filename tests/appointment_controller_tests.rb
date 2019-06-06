# @appointment = Appointment.new('Bob', 'Test Service 1', 'Test', Date.new(2020,1,1), 12)

require '../controllers/service_controller'
require '../controllers/provider_controller'
require '../controllers/appointment_controller'
require '../controllers/client_controller'

RSpec.describe AppointmentController do 
    describe "#add_appointment" do

        clients = ClientController.send :all
        services = ServiceController.send :all
        providers = ProviderController.send :all
        appointments = AppointmentController.send :all

        it "checks no appointments exist" do
            expect(appointments.size()).to eq(0)
            expect(clients[0].appointments.size()).to eq(1)
            expect(providers[0].scheduled_appointments.size()).to eq(0)
        end
        it "adds an appointment to appointment controller" do
            AppointmentController.send :add_appointment, clients[0], services[0], providers[0], Date.new(2020,1,1), 12
            expect(appointments.size()).to eq(1)
        end
        it "check client controller for added appointment" do
            expect(clients[0].appointments.size()).to eq(1)
        end
        it "check provider controller for added appointment" do
            expect(providers[0].scheduled_appointments.size()).to eq(1)
        end
    end

    describe "#remove_appointment" do

        clients = ClientController.send :all
        services = ServiceController.send :all
        providers = ProviderController.send :all
        appointments = AppointmentController.send :all

        it "adds an appointment" do
            # expect(appointments.size()).to eq(0)    
            # AppointmentController.send :add_appointment, clients[0], services[0], providers[0], Date.new(2020,1,1), 12
            expect(appointments.size()).to eq(1)
        end
        it "removes the appointment" do
            AppointmentController.send :remove_appointment, clients[0], services[0], providers[0], Date.new(2020,1,1), 12
            expect(appointments.size()).to eq(0)
        end
        it "checks client controller" do
            expect(clients[0].appointments.size()).to eq(0)
        end
        it "checks provider controller" do
            expect(providers[0].scheduled_appointments.size()).to eq(0)
        end
    end
end