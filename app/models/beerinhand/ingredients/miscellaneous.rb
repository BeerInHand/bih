module Beerinhand
  class Ingredients::Miscellaneous
    include Mongoid::Document
    include Mongoid::Timestamps
    include Beerinhand::Constants

    field :type,        type: String
    field :use,         type: String
    field :unit,        type: String
    field :unit_type,   type: String
    field :phase,       type: String
    field :information, type: String
    field :url,         type: String

    validates :type, presence: true

    validates_inclusion_of :unit, in: :valid_volume_and_weight_units, :message => "unit %s is not included in the list"
    validates_inclusion_of :unit_type, in: :valid_unit_types, :message => "type %s is not included in the list"
    validates_inclusion_of :phase, in: :valid_misc_phases, :message => "phase %s is not included in the list"

    def self.find_or_create_by_id(id)
      where(_id: id).first || create(_id: id)
    end

  end
end
