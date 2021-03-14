require 'rpi_gpio'

module GPIO
  class LED

    @io  = RPi::GPIO.set_numbering :bcm
    @pin = 17

    class << self
      attr_accessor :io, :pin

      def run!
        io.setup pin, as: :output

        10.times do |i|
          puts("#{pin} ON!")
          io.set_low pin
          sleep(0.5)

          puts("#{pin} OFF!")
          io.set_high pin
          sleep(0.5)
        end
      end
    end
  end
end
