require 'tty-prompt'
require 'colorize'
# require '../models/schedule'
require_relative './provider_controller'
provider_services = %w(One Two Three)

def view_schedule
  prompt = TTY::Prompt.new(interrupt: :exit)
  # Let the user know what they will be doing
  prompt.say('----------')
  prompt.say("Let's view a schedule for a Service Provider.\nFirst you'll select a Provider, a Day, then a Service with that Provider.")
  prompt.say('----------')

  # Get Provider
  provider = prompt.select("Choose a Service Provider (hit control + c to exit)", %w(Junius Eddie Vlad))
  day = prompt.select("Choose a day of the week (hit control + c to exit)", %w(Monday Tuesday Wendesday Thursday Friday Saturday Sunday))
  services = prompt.multi_select("Select a service for this day", %w(One Two Three))


end

view_schedule()
