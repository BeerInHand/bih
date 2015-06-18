module Beerinhand
  module Calculators
    class Ibu
      class Tinseth
        include Concerns::IbuCalculation

        def utilization
          (1.65 * 0.000125 ** (gravity.sg - 1.0)) * (1.0 - Math.exp(-0.04 * boiled)) / 4.15
        end

        def form_modifier
          # tinseth formulas based on leaf hops
          return 1.08 if form == :pellet
          return 1.06 if form == :plug
          1.0
        end
      end
    end
  end
end
