module Beerinhand
  class Recipe::FermentableViewModel < ApplicationViewModel

    attr_reader :recipe

    def initialize(model = nil, options = {})
      super
      @recipe = options[:recipe]
    end

    def amount
      @amount ||= 
        Beerinhand::Units::Weight.new(model.amount, recipe.units.grain_units)
    end

    def percent
      amount.grams / recipe.mash_weight.grams
    end

    def mashed?
      model.mash
    end

    def efficency
      mashed? ? recipe.efficency : 100.0
    end

    def points_per_lb
      (model.sgc - 1) * amount.lbs * efficency
    end
  end
end
