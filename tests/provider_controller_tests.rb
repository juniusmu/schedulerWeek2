
# @appointment = Appointment.new('Bob', 'Test Service 1', 'Test', Date.new(2020,1,1), 12)

require '../controllers/service_controller'
require '../controllers/provider_controller'
require '../controllers/appointment_controller'

RSpec.describe ProviderController do 
    describe "#add_provider" do
        it "add a Provider" do
            ProviderController.send :add_provider, 'Test', '123-456-7890', ['Test Service 1']
            providers = ProviderController.send :all

            expect(providers.size()).to eq(1)
        end
    end
end