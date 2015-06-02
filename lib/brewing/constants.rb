module Brewing::Constants

  PHASES = {
    default: :setup,
    setup: :mash,
    mash: :boil,
    boil: :chill,
    chill: :ferment,
    ferment: :package,
    package: :setup
  }

  def valid_volume_units
    @valid_volume_units ||= Brewing::Units::Volume.valid_units.map(&:to_s).map(&:titleize)
  end

  def valid_weight_units
    @valid_weight_units ||= Brewing::Units::Weight.valid_units.map(&:to_s).map(&:titleize)
  end

  def valid_volume_and_weight_units
    @valid_volume_and_weight_units ||= valid_volume_units + valid_weight_units
  end

  def valid_recipe_types
    @valid_recipe_types ||= ['All Grain','Partial Mash','Extract']
  end

  def valid_hop_forms
    @valid_hop_forms ||=  %w(Pellet Leaf Plug)
  end

  def valid_hop_whens
    @valid_hop_whens ||= %w(Boil FWH Dry Mash Whirlpool)
  end

  def valid_misc_phases
    @valid_misc_phases ||= PHASES.map {|k,v| v.to_s.titleize }.uniq
  end

  def valid_unit_types
    @valid_unit_types ||= %w(Weight Volume)
  end

  def valid_gravity_units
    @valid_gravity_units ||= %w(SG Plato)
  end

  def valid_temperature_units
    @valid_temperature_units ||= %w(F C)
  end

  def default_temperature_units
    valid_temperature_units.first
  end

  def default_volume_unit
    'Gallons'
  end

  def default_weight_unit
    'Lbs'
  end

  def default_hop_unit
    'Ounces'
  end

  def default_temperature_unit
    'F'
  end

  def default_volume_and_weight_unit
    valid_volume_and_weight_units.first
  end

  def default_recipe_type
    valid_recipe_types.first
  end

  def default_hop_form
    valid_hop_forms.first
  end

  def default_hop_when
    valid_hop_whens.first
  end

  def default_misc_phase
    PHASES.fetch(:default)
  end

  def default_unit_type
    valid_unit_types.first
  end

  def default_gravity_unit
    valid_gravity_units.first
  end  

end
