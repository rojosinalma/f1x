module GPIO
    def self.clean!
      RPi::GPIO.clean_up
    end
end
