module Beerinhand
  class Recipe::Hop
    include Mongoid::Document
    include Beerinhand::Constants

    field :hop,     type: String
    field :aau,     type: Float
    field :amount,  type: Float
    field :form,    type: String, default: -> { self.default_form }
    field :boiled,  type: Integer
    field :grown,   type: String
    field :phase,   type: String, default: -> { self.default_hop_when }

    embedded_in :recipe, inverse_of: :hops

    validates :hop, presence: true
    validates :aau, numericality: { greater_than_or_equal_to: 0 }
    validates :amount, numericality: { greater_than: 0 }
    validates_inclusion_of :form, in: :valid_hop_forms
    validates :boiled, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
    validates_inclusion_of :phase, in: :valid_hop_phases

  end
end
