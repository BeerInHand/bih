module Beerinhand
  module Units
    class Volume
      include Beerinhand::Units::Concerns::Unit

      CONVERT = {
        barrels: 117.347772,
        hectoliters: 100,
        imp_gallons: 4.54609,
        gallons: 3.785412,
        liters: 1.0,
        quarts: 0.946353,
        pints: 0.4731765,
        cups: 0.2365883,
        ounces: 0.0295735,
        imp_ounces: 0.0284131,
        tablespoons: 0.0147868,
        teaspoons: 0.0049289
      }

      def self.default_units
        :gallons
      end
    end
  end
end
