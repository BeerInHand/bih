module Beerinhand
  module Calculators
    class Alcohol

      attr_accessor :original_gravity, :final_gravity

      def initialize(original_gravity, final_gravity)
        @original_gravity = original_gravity
        @final_gravity = final_gravity
      end

      def abv
        (calculate_abw * 1.25).round(1)
      end

      def abw
        calculate_abw.round(1)
      end

      def calories
        ((6.9 * abw) + 4.0 * (real_extract - 0.1)) * final_gravity.sg * 0.29583333333333334
      end

      def real_extract
        0.1808 * original_gravity.plato + 0.8192 * final_gravity.plato
      end

      private

      def sg_change
        original_gravity.sg - final_gravity.sg
      end

      def original_extract
        original_gravity.plato
      end

      def calculate_abw
        (original_extract - real_extract) / (2.0665 - 0.010665 * original_extract)
      end
    end
  end
end
