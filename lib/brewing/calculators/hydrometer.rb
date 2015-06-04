module Brewing
  module Calculators
    class Hydrometer

      attr_accessor :gravity, :temperature, :calibration_temperature

      def initialize(gravity, temperature, calibration_temp = nil)
        @gravity = gravity
        @temperature = temperature
        @calibration_temperature = calibration_temp || default_calibration_temp
      end

      def correct_gravity
        at_59 = 1.313454 + -0.132674 * calibration_temperature.f + 0.002057793 * squared(calibration_temperature.f) + -0.000002627634 * cubed(calibration_temperature.f)
        sg = gravity.sg + ((1.313454 - (0.132674 * temperature.f) + 0.002067793 * squared(temperature.f) - 0.000002627634 * cubed(temperature.f)) - at_59) / 1000
        Brewing::Units::Gravity.new(sg.round(3), :sg)
      end

      private

      def default_calibration_temp
        Brewing::Units::Temperature.new(59,:f)
      end

      def squared(value)
        value * value
      end

      def cubed(value)
        value * value * value
      end

    end
  end
end
