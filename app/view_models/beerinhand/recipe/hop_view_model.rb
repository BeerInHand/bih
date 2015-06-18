module Beerinhand
  class Recipe::HopViewModel < ApplicationViewModel

    attr_reader :units, :ibu_calc

    def initialize(model = nil, options = {})
      super
      @units = options[:recipe].units
      @ibu_calc = options[:recipe].ibu_calc
    end

    def weight
      @weight ||= 
        Beerinhand::Units::Weight.new(model.amount, units.hop_units)
    end

    def ibu_calc
      @ibu_calc.hop = self
      @ibu_calc
    end

    def ibus
      ibu_calc.ibus
    end

    def weight_for_ibus(value)
      ibu_calc.weight_for_ibus(value)
    end
  end
end
