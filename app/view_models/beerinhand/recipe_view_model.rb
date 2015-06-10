module Beerinhand
  class RecipeViewModel < ApplicationViewModel

    def mash_weight
      fermentables.sum(&:amount)
    end

  end
end
