module Brewing::FixtureMethods

  def create_volume
    Brewing::Units::Volume.new(5, :gallons)
  end

  def create_weight
    Brewing::Units::Weight.new(1, :ounces)
  end

  def create_gravity
    Brewing::Units::Gravity.new(1.048, :sg)
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
end
