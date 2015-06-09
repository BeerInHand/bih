module Brewing
  module Calculators
    class Mash
      module Concerns::MashCalculation
        extend ActiveSupport::Concern

        attr_accessor :mash, :malt_heat_capacity

        def initialize(mash, malt_heat_capacity = 0.4)
          @mash = mash
          @malt_heat_capacity = malt_heat_capacity
        end

        private

        def invalid_temperature_params?(final_temp)
          mash_temp_diff(final_temp).zero? || (mash.volume.value.zero? && mash.weight.value.zero?)
        end

        def vm
          mash.weight.kg + mash.volume.liters
        end

        def mc
          mash_heat_capacity / (mash.weight.kg + mash.volume.liters)
        end

        def temp_diff(start, final)
          start.f - final.f
        end

        def mash_temp_diff(final_temp)
          temp_diff(mash.temperature, final_temp)
        end

        def mash_heat_capacity
          (malt_heat_capacity * mash.weight.kg + mash.volume.liters)
        end
      end
    end
  end
end
