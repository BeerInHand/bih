module Brewing
  module HopUtilization
    class Default

      # tinseth formulas
      # Utilization = (1.65*0.000125^(OG-1))*((1-2.72^(-0.04*Hop Boil Time))/4.14)
      # IBU = Utilization *(oz*(AA% / 100)* 7490) / Volume of Batch in Gallons
      # mgperl[i] = alpha[i]*mass[i]*7490/volume;
      # util[i] = 1.65*Math.pow(0.000125, gravity)*(1-Math.exp(-0.04*time[i]))/4.15;
      # rager formulas
      #  IBU = (Wt * util * AA% * 7489)/(volume * gravity)


      attr_accessor :volume, :gravity, :weight, :hop_form, :aau, :added_during, :boil_length, :boil_volume

      def initialize(volume, gravity, weight, hop_form, aau, added_during, boil_length, boil_volume)
        @volume = volume
        @gravity = gravity
        @weight = weight
        @hop_form = hop_form
        @aau = aau
        @added_during = added_during
        @boil_length = boil_length
        @boil_volume = boil_volume
      end

      def utilization
        return (1.65 * 0.000125 ** (gravity.sg - 1.0)) * (1.0 - Math.exp(-0.04 * boil_length)) / 4.15
        # return (using_pellets? ? 32 : 30) if (added_during == :fwh)
        # return 0 if (added_during == :dry)
        # return 15 if (added_during == :mash)
        # return boil_length / 15 * (using_pellets? ? 12 : 10) if (boil_length <= 15)
        # return boil_length / 30 * (using_pellets? ? 22 : 20) if (boil_length <= 30)
        # return boil_length / 45 * (using_pellets? ? 26 : 24) if (boil_length <= 45)
        # return boil_length / 60 * (using_pellets? ? 28 : 26) if (boil_length <= 60)
        # return boil_length / 90 * (using_pellets? ? 32 : 30) if (boil_length <= 90)
        # (using_pellets? ? 32 : 30)
      end

      def utilization_rager
        18.11 + 13.86 * Math.tanh((boil_length - 31.32) / 18.27)
      end

      def utilization_with_modifiers
        utilization * hop_form_utilization_modifier * added_during_utilization_modifier
      end

      def tinseth
        utilization_with_modifiers * weight.ounces * aau / 100 * 7490 / volume.gallons
      end

      def rager
        (weight.grams * utilization_with_modifiers * aau / 100 * 1000) / (volume.liters * ibu_correction_for_gravity)
      end

      def amount_from_ibus(ibus)
        return 0 if zero_guard_amount?
        grams = ((volume.liters * ibu_correction_for_gravity * ibus) / (utilization / 100 * aau / 100 * 1000))
        Brewing::Units::Weight.new(grams, :grams)
      end

      def ibus_from_amount
        return 0 if zero_guard_ibu?
        (weight.grams * utilization / 100 * aau / 100 * 1000) / (volume.liters * ibu_correction_for_gravity)
      end

      def ibu_correction_for_gravity
        return 1.0 if boil_sg < 1.05
        1.0 + (boil_sg - 1.05) / 0.2
      end

      def boil_sg
        return gravity.sg if boil_volume_eq_volume?
        1 + boil_ratio * (gravity.sg - 1)
      end

      private

      def boil_volume_eq_volume?
        boil_volume.value == 0 || boil_ratio == 1.0
      end

      def using_pellets?
        hop_form == :pellet
      end

      def zero_guard_amount?
        volume.value == 0 || ibus == 0 || aau == 0 || utilization == 0
      end

      def zero_guard_ibu?
        volume.value == 0 || weight.value == 0 || aau == 0 || utilization == 0
      end

      def boil_ratio
        boil_volume.value / volume.send(boil_volume.units)
      end

def hop_form_utilization_modifier
  return 0.92 if hop_form == :plug
  return 0.90 if hop_form == :leaf
  1.0
end

def added_during_utilization_modifier
  return 0.8 if added_during == :mash
  return 1.1 if added_during == :fwh
  1.0
end

    end
  end
end
