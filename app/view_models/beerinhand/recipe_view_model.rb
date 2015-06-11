module Beerinhand
  class RecipeViewModel < ApplicationViewModel

    def initialize(model = nil, options = {})
      super

    end

    def grains
      @grains ||= Recipe::FermentableViewModel.wrap(fermentables, recipe: self)
    end

    def fermentables_weight
      fermentables.sum(&:amount)
    end

    def mash_weight
      @mash_weight ||= Beerinhand::Units::Weight.new(0, units.grain_units)
      @mash_weight.value = fermentables.select(&:mash).sum(&:amount)
      @mash_weight
    end

    def hops_weight
      hops.sum(&:amount)
    end

    def brewed_at
      event = events.detect { |e| e.type=='Brewed' }
      event.present? ? event.event_at : nil
    end

    private

    def perform_calculations
      total = fermentables_weight
      fermentables.each do |f|
        f.percent = (f.amount / total * 100).round(1)
      end
    end
  end
end
