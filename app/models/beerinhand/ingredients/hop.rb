module Beerinhand
  class Ingredients::Hop
    include Mongoid::Document
    include Mongoid::Timestamps

    field :hop,                  type: String
    field :aa_low,               type: Float
    field :aa_high,              type: Float
    field :hsi,                  type: Float
    field :grown,                type: String
    field :profile,              type: String
    field :use,                  type: String
    field :example,              type: String
    field :substitute,           type: String
    field :information,          type: String
    field :url,                  type: String
    field :dry,                  type: Boolean
    field :aroma,                type: Boolean
    field :bitter,               type: Boolean
    field :finish,               type: Boolean

    validates :hop, presence: true
    validates :aa_low, numericality: { greater_than_or_equal_to: 0 }
    validates :aa_high, numericality: { greater_than_or_equal_to: 0 }

    def self.find_or_create_by_id(id)
      where(_id: id).first || create(_id: id)
    end

  end
end
