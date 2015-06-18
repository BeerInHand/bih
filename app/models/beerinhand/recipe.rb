module Beerinhand
  class Recipe
    include Mongoid::Document
    include Mongoid::Timestamps
    include Concerns::Units
    include Beerinhand::Constants

    field :user_id,        type: String
    field :name,           type: String
    field :volume,         type: Float
    field :boil_volume,    type: Float
    field :style,          type: String
    field :recipe_type,    type: String, default: -> { self.default_recipe_type }
    field :efficency,      type: Integer
    field :gravity,        type: Float
    field :srm,            type: Float
    field :ibu,            type: Float
    field :mash,           type: String
    field :primer,         type: String
    field :privacy,        type: Integer, default: 0

    # field :brewed_at,      type: Date
    # field :grain_weight,   type: Float
    # field :mash_weight,    type: Float
    # field :hop_weight,     type: Float

    before_save :perform_calculations

    index({ user_id: 1 })

    belongs_to :user, class_name: 'Beerinhand::User'
    embeds_many :fermentables, class_name: 'Beerinhand::Recipe::Fermentable'
    embeds_many :hops, class_name: 'Beerinhand::Recipe::Hop'
    embeds_many :yeasts, class_name: 'Beerinhand::Recipe::Yeast'
    embeds_many :miscs, class_name: 'Beerinhand::Recipe::Miscellaneous'
    embeds_many :events, class_name: 'Beerinhand::Recipe::Event'

    validates :name, presence: true
    validates :volume, numericality: true
    validates :style, presence: true
    validates :efficency, numericality: { greater_than: 0, less_than_or_equal_to: 100 }
    validates :gravity, numericality: { greater_than: 0 }
    validates :srm, numericality: { greater_than_or_equal_to: 0 }
    validates :ibu, numericality: { greater_than_or_equal_to: 0 }
    validates_inclusion_of :recipe_type, in: :valid_recipe_types

    validates_associated :fermentables
    validates_associated :hops
    validates_associated :yeasts
    validates_associated :miscs
    validates_associated :events

    def self.find_or_create_by_id(id)
      where(_id: id).first || create(_id: id)
    end

    private

    def perform_calculations
    end

  end
end
