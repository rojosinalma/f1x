require 'rpi_gpio'

module GPIO
  class PWMLED04

    class << self
      io  = RPi::GPIO.set_numbering :bcm
      pin = 18

      io.setup pin, as: :output
      io.set_low pin
    end
  end
end
