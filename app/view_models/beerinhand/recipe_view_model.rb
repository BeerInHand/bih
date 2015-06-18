module Beerinhand
  class RecipeViewModel < ApplicationViewModel


    def initialize(model = nil, options = {})
      super
    end

    def hops
      @hops ||= Recipe::HopViewModel.wrap(model.hops, recipe: self)
    end

    def grains
      @grains ||= Recipe::FermentableViewModel.wrap(model.fermentables, recipe: self)
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

    def srm
      Beerinhand::Calculators::Srm.convert(grains.sum(&:hcu_per_lb) / volume.gallons)
    end

    def hops_weight
      hops.sum(&:amount)
    end

    def ibus
      by_formula = ibu_calc.ibus
      hops.map(&:ibus).tap do |data|
        by_formula.rager = data.sum(&:rager)
        by_formula.tinseth = data.sum(&:tinseth)
      end
      by_formula
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
      @ibu_calc ||= Beerinhand::Calculators::Ibu.new(
        volume: volume,
        gravity: gravity,
        boil_volume: boil_volume
      )
    end

    def alcohol
      @alcohol ||= Beerinhand::Calculators::Alcohol.new(gravity, final_gravity)
      @alcohol.original_gravity = gravity
      @alcohol.final_gravity = final_gravity
      @alcohol.alcohol
    end

    private

    def safe_boil_volume
      model.boil_volume.zero? ? model.volume : model.boil_volume
    end

    def perform_calculations
      total = fermentables.sum(&:amount)
      fermentables.each do |f|
        f.percent = (f.amount / total * 100).round(1)
      end
    end

    def final_gravity
      @final_gravity ||= Beerinhand::Units::Gravity.new(gravity.plato / 4, 'Plato')
    end
  end
end
