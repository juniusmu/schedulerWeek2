
require_relative '../controllers/service_controller'
require_relative '../controllers/provider_controller'
require_relative '../controllers/appointment_controller'
require_relative '../seed'


RSpec.describe ServiceController do 
    describe "#add_service" do
        it "adds a Service to global service_list" do
		ServiceController.add_service("Test", "1", "1")
		expect($service_list.size()).to eq(5)	
        end
    end

    describe "#remove_service" do
        it "removes a Service from global service_list" do
		ServiceController.remove_service("Liver Transplants")
        	expect($service_list.size()).to eq(4)	
        end
    end

end
