require 'rpi_gpio'

module GPIO
  class RGB

    @pins   = { red: 17, green: 18, blue: 27 }
    @freqs  = { red: 2000, green: 2000, blue: 5000 }
    @colors = {
      red: 0xFF0000,
      green: 0x00FF00,
      blue: 0x0000FF,
      yellow: 0xFFFF00,
      magenta: 0xFF00FF,
      cyan: 0x00FFFF
    }

    @io     = RPi::GPIO.set_numbering :bcm
    class << self
      attr_accessor :io, :pins, :freqs, :colors, :red, :green, :blue

      def run!

        # Init pins
        pins.each do |name, pin|
          io.setup(pin, as: :output, initialize: :high)
        end

        # Set their frequencies
        @red   = io::PWM.new(pins[:red],   freqs[:red])
        @green = io::PWM.new(pins[:green], freqs[:green])
        @blue  = io::PWM.new(pins[:blue],  freqs[:blue])

        # Set initial duty cycle (leds off)
        red.start(0)
        green.start(0)
        blue.start(0)

        # Change colors
        while true do
          colors.each do |color, hex|
            Logger.info("Changing color: #{color}")
            set_color(hex)
            sleep(0.5)
          end
        end
      end

      # Transforms hex into color number
      def set_color(hex)
        red_value   = (hex & 0xFF0000) >> 16
        green_value = (hex & 0x00FF00) >> 8
        blue_value  = (hex & 0x0000FF) >> 0

        red_value   = map(red_value)
        green_value = map(green_value)
        blue_value  = map(blue_value)

        Logger.debug("rval: #{red_value}")
        Logger.debug("gval: #{green_value}")
        Logger.debug("bval: #{blue_value}")
        Logger.debug("---")

        # Change duty cycle
        red.duty_cycle   = red_value
        green.duty_cycle = green_value
        blue.duty_cycle  = blue_value

        return true
      end

      # Transforms the color number into 0-100 scale.
      def map(target)
        # min     = 0
        # in_max  = 255
        # out_max = 100

        # (x - min) * (out_max - min) / (in_max - min) + min

        (target / 2.55).to_i
      end
    end
  end
end
