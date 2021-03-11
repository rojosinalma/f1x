require 'rpi_gpio'

io  = RPi::GPIO.set_numbering :bcm
pin = 17

io.setup pin, as: :output

10.times do |i|
  puts("#{pin} ON!")
  io.set_low pin
  sleep(0.5)

  puts("#{pin} OFF!")
  io.set_high pin
  sleep(0.5)
end
