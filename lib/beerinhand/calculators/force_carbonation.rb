module Beerinhand
  module Calculators
    class ForceCarbonation

      attr_accessor :temperature, :desired_co2

      def initialize(temperature, desired_co2)
        @temperature = temperature
        @desired_co2 = desired_co2
      end

      def psi
        (-16.6999 - 0.0101059 * temperature.f + 0.00116512 * squared(temperature.f) + 0.173354 * temperature.f * desired_co2 + 4.24267 * desired_co2 - 0.0684226 * squared(desired_co2)).round(1)
      end

      private

      def squared(value)
        value * value
      end
    end
  end
end
