require 'rpi_gpio'

module GPIO
  class Beep

    @pins = { beep: 17, red_led: 27, green_led: 18 }
    @io  = RPi::GPIO.set_numbering :bcm

    class << self
      attr_accessor :io, :pins

      def run!

        # Init pins
        pins.each do |name, pin|
          Logger.info("Setting up #{pin} for #{name}")
          io.setup(pin, as: :output, initialize: :high)
        end

        trap("SIGINT") { throw :done }
        catch :done do
          begin
            loop do
              io.set_low pins[:beep]
              io.set_low pins[:red_led]
              io.set_high pins[:green_led]
              sleep(0.1)

              io.set_high pins[:beep]
              io.set_high pins[:red_led]
              io.set_low pins[:green_led]
              sleep(0.1)
            end
          rescue Exception => e
            Logger.error(e.full_message)
            clean!
            break
          end
        end
      end
    end
  end
end
