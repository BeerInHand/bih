module Beerinhand
  class Recipe::Fermentable
    include Mongoid::Document

    field :fermentable,  type: String
    field :amount,       type: Float
    field :sgc,          type: Float, default: 1.000
    field :lovibond,     type: Integer
    field :mash,         type: Boolean, default: false
    field :maltster,     type: String
    field :percent,      type: Float

    embedded_in :recipe, inverse_of: :fermentables

    validates :fermentable, presence: true
    validates :amount, numericality: { greater_than: 0 }
    validates :sgc, numericality: { greater_than_or_equal_to: 1.0 }
    validates :lovibond, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  end
end
