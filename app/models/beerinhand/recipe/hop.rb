module Beerinhand
  class Recipe::Hop
    include Mongoid::Document
    include Beerinhand::Constants

    field :hop,        type: String
    field :aau,        type: Float
    field :amount,     type: Float
    field :form,       type: String, default: -> { self.default_hop_form }
    field :boil_time,  type: Integer
    field :grown,      type: String
    field :when,       type: String, default: -> { self.default_hop_when }

    embedded_in :recipe, inverse_of: :hops

    validates :hop, presence: true
    validates :aau, numericality: { greater_than_or_equal_to: 0 }
    validates :amount, numericality: { greater_than: 0 }
    validates_inclusion_of :form, in: :valid_hop_forms
    validates :boil_time, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
    validates_inclusion_of :when, in: :valid_hop_whens

  end
end
