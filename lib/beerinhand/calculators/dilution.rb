module Beerinhand
  module Calculators
    class Dilution

      attr_accessor :wort

      def initialize(wort)
        @wort = wort
      end

      def add_wort(wort_added)
        wort_final = Beerinhand::Brewing::Wort.new(wort.volume.clone, wort.gravity.clone)
        wort_final.volume.liters = wort.volume.liters + wort_added.volume.liters
        wort_final.gravity.sg = 1 + (points(wort) + points(wort_added)) / wort_final.volume.liters
        wort_final
      end

      private

      def points(wort)
        (wort.gravity.sg - 1) * wort.volume.liters
      end
    end
  end
end
