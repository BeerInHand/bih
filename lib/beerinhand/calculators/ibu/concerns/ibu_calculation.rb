module Beerinhand
  module Calculators
    class Ibu
      module Concerns::IbuCalculation
        extend ActiveSupport::Concern
        include Beerinhand::Constants

        included do
          attr_accessor :volume, :gravity, :weight, :form, :aau, :phase, :boiled, :boil_volume
        end

        def initialize(params = {})
          @volume = params[:volume] || Units::Volume.new(5, :gallons)
          @gravity = params[:gravity] || Units::Gravity.new(1.048, :sg)
          @weight = params[:weight] || Units::Weight.new(1, :ounces)
          @form = params[:form] || :pellet
          @aau = params[:aau] || 10.0
          @phase = params[:phase] || :boil
          @boiled = params[:boiled] || 90
          @boil_volume = params[:boil_volume] || Units::Volume.new(5, :gallons)
        end

        def ibus=(ibus)
          grams = volume.liters * ibu_correction_for_gravity * ibus / aau_utilization
          Units::Weight.new(grams, :grams)
        end

        def ibus
          return 0 if volume.value == 0
          weight.grams * aau_utilization / volume.liters * ibu_correction_for_gravity
        end

        def utilization_with_modifiers
          utilization * form_modifier * phase_modifier
        end

        def form_modifier
          1.0
        end

        def phase_modifier
          return 0.8 if phase == :mash
          return 1.1 if phase == :fwh
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
