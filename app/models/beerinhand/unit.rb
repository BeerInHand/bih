module Beerinhand
  class Unit
    include Mongoid::Document
    include Beerinhand::Constants

    field :grain_units,    type: String, default: -> { self.default_weight_unit }
    field :gravity_units,  type: String, default: -> { self.default_gravity_unit }
    field :hop_units,      type: String, default: -> { self.default_hop_unit }
    field :temp_units,     type: String, default: -> { self.default_temperature_unit }
    field :volume_units,   type: String, default: -> { self.default_volume_unit }

    embedded_in :unitable, polymorphic: true

    validates_inclusion_of :grain_units,  in: :valid_weight_units
    validates_inclusion_of :gravity_units, in: :valid_gravity_units
    validates_inclusion_of :hop_units,  in: :valid_weight_units
    validates_inclusion_of :temp_units,  in: :valid_temperature_units
    validates_inclusion_of :volume_units, in: :valid_volume_units

  end
end
