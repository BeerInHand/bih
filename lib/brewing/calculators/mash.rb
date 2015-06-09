module Brewing
  module Calculators
    class Mash

      ByMethod = Struct.new(:infuse, :decoct)

      attr_accessor :mash, :infuse, :decoct

      def initialize(mash)
        @mash = mash
        @infuse = Infusion.new(mash)
        @decoct = Decoction.new(mash)
      end

      def amount_to_raise_temp(added_temp, final_temp)
        ByMethod.new(
          infuse.volume_required_for_temperature(added_temp, final_temp), 
          decoct.weight_required_for_temperature(added_temp, final_temp)
          )
      end

    end
  end
end
