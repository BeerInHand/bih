module Brewing
  module Calculators
    class Infusion
      include Mash::Concerns::MashCalculation

      def volume_required_for_temperature(added_temp, final_temp)
        liters = infusion_in_liters(added_temp, final_temp)
        Brewing::Units::Volume.new(liters, :liters)
      end

      def temperature_required_for_volume(volume_infused, final_temp)
        f = infusion_in_f(volume_infused, final_temp)
        Brewing::Units::Temperature.new(f, :f)
      end

      private

      def infusion_in_liters(added_temp, final_temp)
        return 0 if invalid_temperature_params?(final_temp)

        mc * vm * mash_temp_diff(final_temp) / temp_diff(final_temp, added_temp)
      end

      def infusion_in_f(volume_infused, final_temp)
        return mash.temperature.f if volume_infused.liters.zero?
        -(mc * vm * mash_temp_diff(final_temp) - volume_infused.liters * final_temp.f) / volume_infused.liters
      end
    end
  end
end
