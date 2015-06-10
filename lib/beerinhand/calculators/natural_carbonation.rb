module Beerinhand
  module Calculators
    class NaturalCarbonation

      PRIMER = {
        black_treacle:          0.330005,
        brown_sugar:            0.322141,
        belgian_candy_syrup:    0.45178,
        belgian_candy_sugar:    0.381074,
        corn_syrup:             0.416438,
        corn_sugar:             0.314278,
        demarara:               0.286,
        dme:                    0.418793,
        dextrose:               0.314278,
        honey:                  0.385006,
        invert_sugar_syrup:     0.314278,
        molasses:               0.400711,
        maple_syrup:            0.369279,
        rice_solids:            0.361438,
        sorghum_syrup:          0.416438,
        sucrose:                0.286,
        cane_sugar:             0.286,
        turbinado:              0.286
      }

      attr_accessor :temperature, :volume, :co2

      def self.is_valid_primer?(type)
        valid_types.include? type
      end

      def self.default_type
        :corn_sugar
      end

      def self.valid_types
        self::PRIMER.keys
      end

      def self.scrub_primer(primer)
        valid_types.detect { |r| r == primer.downcase.to_sym } || default_type
      end

      def initialize(temperature, volume, co2)
        @temperature = temperature
        @volume = volume
        @co2 = co2
      end

      def co2_generated_by_primer(primer, weight)
        weight.grams * primer.factor / volume.liters
      end

      def saturated_co2
        70.81 / ( temperature.f + 12.4)
      end

      def method_missing(method_name, *args, &block)
        raise NoMethodError unless self.class.is_valid_primer?(method_name)
        amount_required_for_co2(method_name)
      end

      private

      def factor(primer)
        self.class::PRIMER.fetch(primer)
      end

      def co2_required(co2)
        co2 - saturated_co2
      end

      def amount_required_for_co2(primer)
        grams = co2_required(co2) / factor(primer) * volume.liters
        Beerinhand::Units::Weight.new(grams, :grams)
      end
    end
  end
end
