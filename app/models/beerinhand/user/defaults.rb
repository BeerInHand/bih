module Beerinhand
  class User::Defaults
    include Mongoid::Document
    include Beerinhand::Concerns::Units
    include Beerinhand::Constants

    field :volume,         type: Float   
    field :boil_volume,    type: Float   
    field :efficency,      type: Float
    field :hop_forms,      type: String, default: -> { self.default_form }
    field :hydro_temp,     type: Float     
    field :primer,         type: String   
    field :privacy,        type: Integer
    field :recipe_type,    type: String, default: -> { self.default_recipe_type }

    embedded_in :User, inverse_of: :defaults

    validates :volume, numericality: { greater_than: 0 }
    validates :boil_volume, numericality: { greater_than: 0 }
    validates :efficency, numericality: { greater_than: 0 }
    validates_inclusion_of :hop_forms, in: :valid_hop_forms
    validates :hydro_temp, numericality: { greater_than: 0 }
    validates_inclusion_of :recipe_type, in: :valid_recipe_types

  end
end
