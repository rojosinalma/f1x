require 'rpi_gpio'

module GPIO
  class Motor

    @pins = { motor_1: 17, motor_2: 18, motor_enable: 27 }
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
              Logger.info("Starting engine clockwise")
              io.set_high pins[:motor_enable]
              io.set_high pins[:motor_1]
              io.set_low  pins[:motor_2]
              sleep(2)

              Logger.info("Stopping engine")
              io.set_low  pins[:motor_enable]
              sleep(2)

              Logger.info("Starting engine counter clockwise")
              io.set_high pins[:motor_enable]
              io.set_low  pins[:motor_1]
              io.set_high pins[:motor_2]
              sleep(2)

              Logger.info("Stopping engine")
              io.set_low pins[:motor_enable]
              sleep(2)

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
