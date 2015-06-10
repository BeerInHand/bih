module Beerinhand
  module Calculators
    class Ibu
      module Concerns::IbuCalculation
        extend ActiveSupport::Concern
        include Beerinhand::Constants

        included do
          attr_accessor :volume, :gravity, :weight, :hop_form, :aau, :added_during, :boil_length, :boil_volume
        end

        def initialize(params = {})
          @volume = params[:volume] || Units::Volume.new(5, :gallons)
          @gravity = params[:gravity] || Units::Gravity.new(1.048, :sg)
          @weight = params[:weight] || Units::Weight.new(1, :ounces)
          @hop_form = params[:hop_form] || :pellet
          @aau = params[:aau] || 10.0
          @added_during = params[:added_during] || :boil
          @boil_length = params[:boil_length] || 90
          @boil_volume = params[:boil_volume] || Units::Volume.new(5, :gallons)
        end

        def ibus=(ibus)
          weight.grams = volume.liters * ibu_correction_for_gravity * ibus / aau_utilization
        end

        def ibus
          return 0 if volume.value == 0
          weight.grams * aau_utilization / volume.liters * ibu_correction_for_gravity
        end

        def utilization_with_modifiers
          utilization * hop_form_modifier * added_during_modifier
        end

        def hop_form_modifier
          1.0
        end

        def added_during_modifier
          return 0.8 if added_during == :mash
          return 1.1 if added_during == :fwh
          1.0
        end

        private

        def ibu_correction_for_gravity
          1.0
        end

        def aau_utilization
          utilization_with_modifiers * aau / 100 * 1000
        end
      end
    end
  end
end
