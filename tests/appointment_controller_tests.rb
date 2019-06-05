# @appointment = Appointment.new('Bob', 'Test Service 1', 'Test', Date.new(2020,1,1), 12)

require '../controllers/service_controller'
require '../controllers/provider_controller'
require '../controllers/appointment_controller'

RSpec.describe AppointmentController do 
    describe "#add_appointment" do
        it "add an appointment" do
            providers = ProviderController.send :all
            AppointmentController.send :add_appointment, 'Bob', 'Test Service 1', providers[0], Date.new(2020,1,1), 12
            appointments = AppointmentController.send :all

            expect(appointments.size()).to eq(1)
        end
    end
end