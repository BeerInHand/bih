module Brewing::FixtureMethods

  def create_volume(volume = 5, units = :gallons)
    Brewing::Units::Volume.new(volume, units)
  end

  def create_weight(weight = 1, units = :ounces)
    Brewing::Units::Weight.new(weight, units)
  end

  def create_temperature(temp = 60, units = :f)
    Brewing::Units::Temperature.new(temp, units)
  end

  def create_gravity(gravity = 1.048, units = :sg)
    Brewing::Units::Gravity.new(gravity, units)
  end

  def create_mash
    Brewing::Mash.new(create_volume, create_weight, create_temperature)
  end  

  def create_wort
    Brewing::Wort.new(create_volume, create_gravity)
  end

  def create_ibu_calc(overrides = {})
    attributes = {
      volume: create_volume,
      gravity: create_gravity,
      weight: create_weight,
      hop_form: :pellet,
      aau: 10.0,
      added_during: :boil,
      boil_length: 90,
      boil_volume: create_volume
    }.merge(overrides)

    Brewing::Calculators::Ibu.new(attributes)
  end

  def create_natural_carbonation
    Brewing::Calculators::NaturalCarbonation.new(create_temperature, create_volume, 2.5)
  end

  def create_alcohol_calculator
    og = create_gravity(1.048)
    fg = create_gravity(1.012)
    alcohol = Brewing::Calculators::Alcohol.new(og, fg)
  end

  def create_dilution_calculator
    Brewing::Calculators::Dilution.new(create_wort)
  end

  def create_decoction_calculator
    Brewing::Calculators::Decoction.new(create_mash)
  end

  def create_infusion_calculator
    Brewing::Calculators::Infusion.new(create_mash)
  end
end
