module Brewing
  module Calculators
    class Ibu
      class Tinseth
        include Concerns::IbuCalculation

        def utilization
          (1.65 * 0.000125 ** (gravity.sg - 1.0)) * (1.0 - Math.exp(-0.04 * boil_length)) / 4.15
        end

        def hop_form_modifier
          # tinseth formulas based on leaf hops
          return 1.08 if hop_form == :pellet
          return 1.06 if hop_form == :plug
          1.0
        end
      end
    end
  end
end
