module Beerinhand
  class Recipe::Yeast
    include Mongoid::Document

    field :yeast,              type: String
    field :laboratory,         type: String
    field :lab_id,             type: String
    field :pitched_at,         type: DateTime
    field :note,               type: String

    embedded_in :recipe, inverse_of: :yeasts

    validates :yeast, presence: true

  end
end
