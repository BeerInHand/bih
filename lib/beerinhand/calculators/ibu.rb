module Beerinhand
  module Calculators
    class Ibu
      # http://rhbc.co/wiki/calculating-ibus

      attr_accessor :rager, :tinseth

      ByFormula = Struct.new(:rager, :tinseth)

      def initialize(params = {})
        @rager = Rager.new(params)
        @tinseth = Tinseth.new(params)
      end

      def ibus
        ByFormula.new(rager.ibus, tinseth.ibus)
      end

      def weights
        ByFormula.new(rager.weight, tinseth.weight)
      end

      def weight_for_ibus(value)
        ByFormula.new(
          rager.send("ibus=", value),
          tinseth.send("ibus=", value)
        )
      end

      def hop=(hop)
        [:weight, :form, :aau, :phase, :boiled].each do |field|
          set "#{field}=", hop.send(field)
        end
      end

      def method_missing(method_name, *args, &block)
        field = self.class.field_from_method(method_name)
        raise NoMethodError unless set_list.include?(field)
        set(method_name, args[0])
      end

      private

      def set_list
        [:volume, :gravity, :weight, :form, :aau, :phase, :boiled, :boil_volume]
      end

      def self.field_from_method(method_name)
        method_name.to_s.gsub(/=$/,'').to_sym
      end

      def set(field, value)
        rager.send(field, value)
        tinseth.send(field, value)
      end
    end
  end
end
