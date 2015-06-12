module Beerinhand
  class RecipeViewModel < ApplicationViewModel


    def initialize(model = nil, options = {})
      super
    end

    def hops
      @hops ||= Recipe::HopViewModel.wrap(hops, recipe: self)
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

    def gravity
      @gravity ||= Beerinhand::Units::Gravity.new(model.gravity, units.gravity_units)
      @gravity.sg = 1 + grains.sum(&:points_per_lb) / volume.gallons
      @gravity
    end

    def hops_weight
      hops.sum(&:amount)
    end

    def ibu
      hops.map(&:ibus)
    end

    def brewed_at
      event = events.detect { |e| e.type=='Brewed' }
      event.present? ? event.event_at : nil
    end

    def volume
      @volume ||= Beerinhand::Units::Volume.new(model.volume, units.volume_units)
    end

    def boil_volume
      @boil_volume ||= Beerinhand::Units::Volume.new(safe_boil_volume, units.volume_units)
    end

    def efficency
      model.efficency / 100.0
    end

    def ibu_calc
      @ibu_calc = Beerinhand::Calculators::Ibu.new(
        volume: volume,
        gravity: gravity,
        boil_volume: boil_volume
      )
    end

    private


    def safe_boil_volume
      model.boil_volume.zero? ? model.volume : model.boil_volume
    end

    def perform_calculations
      total = fermentables_weight
      fermentables.each do |f|
        f.percent = (f.amount / total * 100).round(1)
      end
    end
  end
end
