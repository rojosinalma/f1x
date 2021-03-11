#!/usr/bin/env ruby

require 'bundler'
Bundler.setup
Bundler.require

require 'wiringpi2'

high   = WiringPi::HIGH
low    = WiringPi::LOW
input  = WiringPi::OUTPUT
output = WiringPi::OUTPUT

led_pin = 0

# Setup here
io = WiringPi::GPIO.new do |gpio|
  gpio.pin_mode(led_pin, output)
  gpio.digital_write(led_pin, high)
end


1000.times do
  puts("#{led_pin} on...")
  io.digital_write(led_pin, low)
  sleep(0.5)

  puts("#{led_pin} off...")
  io.digital_write(led_pin, high)
  sleep(0.5)
end




# pin_state = io.digital_read(1) # Read from pin 1
# puts pin_state

# io.digital_write(0, high) # Turn pin 0 on
# io.delay(100) # Wait
# io.digital_write(0, low)  # Turn pin 0 off
