module Brewing
  module Units
    module Concerns::Unit
      extend ActiveSupport::Concern

      included do
        attr_accessor :value, :units
      end

      module ClassMethods
        def is_valid_unit?(unit)
          valid_units.include? unit
        end

        def default_units
          valid_units.first
        end

        def valid_units
          self::CONVERT.keys
        end

        def scrub_unit(unit)
          valid_units.detect { |s| s == unit.downcase.to_sym } || default_units
        end

        def unit_from_method(method_name)
          method_name.to_s.gsub(/=$/,'').to_sym
        end

        def is_setter?(method_name)
          /=$/ =~ method_name
        end
      end

      def initialize(value, units)
        @value = value.to_f
        @units = self.class.scrub_unit(units)
      end

      def method_missing(method_name, *args, &block)
        unit = self.class.unit_from_method(method_name)
        raise NoMethodError unless self.class.is_valid_unit?(unit)
        return set(unit, args[0]) if self.class.is_setter?(method_name)
        convert(unit)
      end

      private

      def fetch(units)
        self.class::CONVERT.fetch(units)
      end

      def convert(units_out)
        return value if units == units_out || value == 0
        (value * fetch(units) / fetch(units_out)).round(2)
      end

      def set(units, value)
        @value = value.to_f
        @units = units
      end
    end
  end
end
