#!/usr/bin/env ruby

require 'bundler'
Bundler.setup
Bundler.require

io = WiringPi::GPIO.new do |gpio|
  gpio.pin_mode(0, WiringPi::OUTPUT)
  gpio.pin_mode(1, WiringPi::INPUT)
end

pin_state = io.digital_read(1) # Read from pin 1
puts pin_state

io.digital_write(0, WiringPi::HIGH) # Turn pin 0 on
io.delay(100)                       # Wait
io.digital_write(0, WiringPi::LOW)  # Turn pin 0 off
