module Beerinhand
  module Brewing
    class Wort

      attr_accessor :volume, :gravity

      def initialize(volume, gravity)
        @volume = volume.clone
        @gravity = gravity.clone
      end
    end
  end
end
