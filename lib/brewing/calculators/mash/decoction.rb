module Brewing
  module Calculators
    class Mash
      class Decoction
        include Concerns::MashCalculation

        def weight_required_for_temperature(added_temp, final_temp)
          kg = decoction_weight_in_kg(added_temp, final_temp)
          Brewing::Units::Weight.new(kg, :kg)
        end

        def temperature_required_for_weight(weight_decocted, final_temp)
          f = decoction_temperature_in_f(weight_decocted, final_temp)
          Brewing::Units::Temperature.new(f, :f)
        end

        private

        def decoction_weight_in_kg(added_temp, final_temp)
          return 0 if invalid_temperature_params?(final_temp)

          differential = 1 + temp_diff(final_temp, added_temp) / mash_temp_diff(final_temp)
          return 0 if differential.zero?
          mash_heat_capacity / differential
        end

        def decoction_temperature_in_f(weight_decocted, final_temp)
          return temp_start.f if weight_decocted.value.zero?

          -(mc * vm / weight_decocted.kg * mash_temp_diff(final_temp) - temp_start.f)
        end
      end
    end
  end
end
