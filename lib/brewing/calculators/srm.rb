module Brewing
  module Calculators
    class Srm
      def self.convert(mcu)
         1.4922 * mcu ** 0.6859
      end
    end
  end
end
