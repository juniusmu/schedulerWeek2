# @appointment = Appointment.new('Bob', 'Test Service 1', 'Test', Date.new(2020,1,1), 12)

require '../controllers/service_controller'
require '../controllers/provider_controller'
require '../controllers/appointment_controller'

RSpec.describe AppointmentController do 
    describe "#add_appointment" do
        it "add an appointment" do
            # need to create a provider when provider_controller is refactored
            providers = ProviderController.send :all
            AppointmentController.send :add_appointment, 'Bob', 'Test Service 1', providers[0], Date.new(2020,1,1), 12
            appointments = AppointmentController.send :all

            expect(appointments.size()).to eq(1)
        end
    end

    describe "#remove_appointment" do
        it "removes an appointment" do
            # need to create a provider when provider_controller is refactored
            providers = ProviderController.send :all
            AppointmentController.send :add_appointment, 'Bob', 'Test Service 1', providers[0], Date.new(2020,1,1), 12
            
            AppointmentController.send :remove_appointment
            appointments = AppointmentController.send :all

            expect(appointments.size()).to eq(0)
            # check provider appointments array
            # check clients appointments array
        end
    end
end