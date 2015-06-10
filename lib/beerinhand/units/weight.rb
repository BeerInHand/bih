module Beerinhand
  module Units
    class Weight
      include Concerns::Unit

      CONVERT = {
        kg: 1000,
        lbs: 453.59237,
        ounces: 28.3495231,
        grams: 1
      }

      def self.default_unit
        :lbs
      end

    end
  end
end
