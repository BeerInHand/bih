module Beerinhand
  class Recipe::Miscellaneous
    include Mongoid::Document
    include Beerinhand::Constants

    field :type,        type: String
    field :amount,      type: Float
    field :unit,        type: String
    field :unit_type,   type: String
    field :note,        type: String
    field :phase,       type: String, default: -> { self.default_misc_phase }
    field :action,      type: String
    field :offset,      type: Integer
    field :added,       type: String
    field :sort,        type: String

    embedded_in :recipe, inverse_of: :miscs

    validates :type, presence: true
    validates :amount, numericality: { greater_than: 0, :message => "amount %s must be greater_than: 0" }
    validates_inclusion_of :unit, in: :valid_volume_and_weight_units, :message => "unit %s is not included in the list"
    validates_inclusion_of :unit_type, in: :valid_unit_types, :message => "type %s is not included in the list"
    validates_inclusion_of :phase, in: :valid_misc_phases, :message => "phase %s is not included in the list"

  end
end
