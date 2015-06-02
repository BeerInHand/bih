module Brewing
  module Calculators
    class Ibu
      # http://rhbc.co/wiki/calculating-ibus

      ByFormula = Struct.new(:rager, :tinseth)

      attr_accessor :rager, :tinseth

      def initialize(volume, gravity, weight, hop_form, aau, added_during, boil_length, boil_volume)
        @rager = Rager.new(volume, gravity, weight, hop_form, aau, added_during, boil_length, boil_volume)
        @tinseth = Tinseth.new(volume, gravity, weight, hop_form, aau, added_during, boil_length, boil_volume)
      end

      def ibus
        ByFormula.new(rager.ibus, tinseth.ibus)
      end

      def weights
        ByFormula.new(rager.weight, tinseth.weight)
      end

      def ibus=(ibu)
        rager.ibus = ibu
        tinseth.ibus = ibu
      end
    end
  end
end
