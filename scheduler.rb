require 'tty-prompt'
require './controllers/service_controller'
require './controllers/provider_controller'
require './controllers/appointment_controller'

class Scheduler
	FUNCTION_LOOKUP = {
		"Add Provider" => {
			controller: ProviderController,
			method_name: :add
		},
		"Remove Provider" => {
			controller: ProviderController,
			method_name: :remove
		},
		"Add Service" => {
			controller: ServiceController,
			method_name: :add
		},
		"Add Provider Availability" => {
			controller: ProviderController,
			method_name: :add_availability
		},
		"Remove Provider Availability" => {
			controller: ProviderController,
			method_name: :remove_availability
		},
		"Remove Service" => {
			controller: ServiceController,
			method_name: :remove
		},
		"Schedule an Appointment" => {
			controller: AppointmentController,
			method_name: :add
		},
		"View Schedule of a Particular Provider" => {
			controller: ProviderController,
			method_name: :view_schedule
		}
	}

	continue_program = true
	prompt = TTY::Prompt.new(interrupt: :exit)

	while continue_program do
		choice = prompt.select("What would you like to do? (press 'control-c' to quit)", FUNCTION_LOOKUP.keys)
		FUNCTION_LOOKUP[choice][:controller].send(FUNCTION_LOOKUP[choice][:method_name])
	end
end
    

