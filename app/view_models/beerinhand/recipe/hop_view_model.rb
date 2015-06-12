module Beerinhand
  class Recipe::HopViewModel < ApplicationViewModel

    attr_reader :recipe

    def initialize(model = nil, options = {})
      super
      @recipe = options[:recipe]
    end

    def amount
      @amount ||= 
        Beerinhand::Units::Weight.new(model.amount, recipe.units.hop_units)
    end

    def ibu
      recipe.ibu_calc.weight = amount
      recipe.ibu_calc.hop_form = hop_form
      recipe.ibu_calc.aau = aau
      recipe.ibu_calc.added_during = added_during
      recipe.ibu_calc.boil_length = boil_length
      recipe.ibu_calc.ibus
    end
  end
end
