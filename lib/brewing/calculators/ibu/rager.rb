module Brewing
  module Calculators
    class Ibu
      class Rager
        include Concerns::IbuCalculation

        def utilization
          (18.11 + 13.86 * Math.tanh((boil_length - 31.32) / 18.27)) / 100
        end

        def hop_form_modifier
          # rager formulas based on pellet hops
          return 0.92 if hop_form == :plug
          return 0.90 if hop_form == :leaf
          1.0
        end

        private

        def ibu_correction_for_gravity
          return 1.0 if boil_sg < 1.05
          1.0 + (boil_sg - 1.05) / 0.2
        end

        def boil_sg
          return gravity.sg if boil_volume_eq_volume?
          1 + boil_ratio * (gravity.sg - 1)
        end

        def boil_volume_eq_volume?
          boil_volume.value == 0 || boil_ratio == 1.0
        end

        def boil_ratio
          return 1.0 if volume.value == 0
          boil_volume.value / volume.send(boil_volume.units)
        end
      end
    end
  end
end
