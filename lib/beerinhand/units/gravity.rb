module Beerinhand
  module Units
    class Gravity
      include Beerinhand::Units::Concerns::Unit

      def self.valid_units
        [ :sg, :plato ]
      end

      def self.default_unit
        :sg
      end

      private

      def convert(units_out)
        send("to_#{units_out.to_s}", units_out)
      end

      def to_sg(units_out)
        return value.round(3) if units == units_out
        (1 + value / (258.6 - value / 258.2 * 227.1)).round(3)
      end

      def to_plato(units_out)
        return value.round(1) if units == units_out
        (-1 * 616.868 + 1111.14 * value - 630.272 * value * value + 135.997 * value * value * value).round(1)
      end
    end
  end
end
