require 'rpi_gpio'

module GPIO
  class PWMLED04

    @io   = RPi::GPIO.set_numbering :bcm
    @pin  = 18
    @freq = 1000

    class << self
      attr_accessor :io, :pin, :freq

      def run!
        io.setup(pin, as: :output, initialize: :high)

        pwm = io::PWM.new(pin, freq)
        pwm = pwm.start(0)

        loop do
          while true do
            Logger.info("Increasing frequency")
            (0..100).step(4).each do |i|
              pwm.duty_cycle = i
              Logger.debug(i)
              sleep(0.05)
            end
            sleep(1)

            Logger.info("Decreasing frequency")
            (100..0).step(-4).each do |i|
              pwm.duty_cycle = i
              Logger.debug(i)
              sleep(0.05)
            end
            sleep(1)

          end
        end
      end
    end
  end
end
