module Brewing::FixtureMethods

  def create_volume(overrides = {})
    params = {
      volume: 5,
      units: :gallons
    }.merge(overrides)
    Brewing::Units::Volume.new(params[:volume], params[:units])
  end

  def create_weight(overrides = {})
    params = {
      weight: 1,
      units: :ounces
    }.merge(overrides)
    Brewing::Units::Weight.new(params[:weight], params[:units])
  end

  def create_temperature(overrides = {})
    params = {
      temp: 60,
      units: :f
    }.merge(overrides)
    Brewing::Units::Temperature.new(params[:temp], params[:units])
  end

  def create_gravity(overrides = {})
    params = {
      gravity: 1.048,
      units: :sg
    }.merge(overrides)
    Brewing::Units::Gravity.new(params[:gravity], params[:units])
  end

  def create_wort(overrides = {})
    params = {
      volume: 5,
      units: :gallons,
      gravity: 1.048,
      units: :sg
    }.merge(overrides)

    Brewing::Wort.new(
      create_volume(params),
      create_gravity(params)
    )
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
    og = create_gravity(gravity: 1.048)
    fg = create_gravity(gravity: 1.012)
    alcohol = Brewing::Calculators::Alcohol.new(og, fg)
  end

  def create_dilution_calculator(overrides = {})
    params = {
      wort: create_wort
    }.merge(overrides)
    Brewing::Calculators::Dilution.new(params[:wort])
  end
end
