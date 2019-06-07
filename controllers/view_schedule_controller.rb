require 'tty-prompt'
require 'colorize'
require_relative './provider_controller'
require_relative './appointment_controller'

class ViewScheduleController
  def self.view_schedule
    appointments = AppointmentController.all
    puts appointments
    prompt = TTY::Prompt.new(interrupt: :exit)
    # Let the user know what they will be doing
    prompt.say('----------')
    prompt.say("Let's view a schedule for a Service Provider.\nFirst you'll select a Provider, a Day, then a Service with that Provider.")
    prompt.say('----------')

    # Get Provider
    provider = prompt.select("Choose a Service Provider (hit control + c to exit)", %w(Junius Eddie Vlad))

    # Get Day
    day = prompt.select("Choose a day of the week (hit control + c to exit)", %w(Monday Tuesday Wendesday Thursday Friday Saturday Sunday))

    # Get Services for each Provider on a particular day
    appointments = AppointmentController    
    services = prompt.multi_select("Select a service for this day", %w(One Two Three))
  end
end
