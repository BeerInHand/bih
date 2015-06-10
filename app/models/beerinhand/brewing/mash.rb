module Beerinhand
  module Brewing
    class Mash

      attr_accessor :volume, :weight, :temperature

      def initialize(volume, weight, temperature)
        @volume = volume.clone
        @weight = weight.clone
        @temperature = temperature.clone
      end
    end
  end
end
