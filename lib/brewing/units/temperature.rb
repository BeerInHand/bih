module Brewing
  module Units
    class Temperature
      include Concerns::Unit

      def self.valid_units
        [ :f, :c ]
      end

      def self.default_unit
        :f
      end

      private

      def convert(units_out)
        return value if units == units_out
        send("to_#{units_out.to_s}")
      end

      def to_f
        (value * 1.8) + 32
      end

      def to_c
        (value - 32) / 1.8
      end
    end
  end
end
