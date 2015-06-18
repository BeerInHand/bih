module Beerinhand
  class Ingredients::Fermentable
    include Mongoid::Document
    include Mongoid::Timestamps

    field :fermentable,   type: String
    field :lovibond,      type: Float
    field :sgc,           type: Float, default: 1.000
    field :lintner,       type: Integer
    field :mash,          type: Boolean, default: false
    field :maltster,      type: String
    field :country,       type: String
    field :information,   type: String
    field :category,      type: String
    field :url,           type: String
    field :mc,            type: Float
    field :fgdb,          type: Float
    field :cgdb,          type: Float
    field :fcdif,         type: Float
    field :protein,       type: Float

    validates :fermentable, presence: true
    validates :sgc, numericality: { greater_than_or_equal_to: 1.0 }
    validates :lovibond, numericality: { greater_than_or_equal_to: 0 }
    validates :lintner, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

    def self.find_or_create_by_id(id)
      where(_id: id).first || create(_id: id)
    end

  end
end
