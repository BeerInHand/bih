module Beerinhand
  class Ingredients::Yeast
    include Mongoid::Document
    include Mongoid::Timestamps
    include Beerinhand::Constants

    field :yeast,               type: String
    field :type,                type: String
    field :form,                type: String
    field :laboratory,          type: String
    field :lab_id,              type: String
    field :url,                 type: String
    field :floculation,         type: String
    field :tolerance,           type: String
    field :information,         type: String
    field :attenuation,         type: String
    field :attenuation_low,     type: Integer
    field :attenuation_high,    type: Integer
    field :temp_low,            type: Integer
    field :temp_high,           type: Integer
    field :temp_units,          type: String

    validates :yeast, presence: true
    validates :type, presence: true
    validates :form, presence: true
    validates :temp_units, presence: true

    validates :attenuation_low, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
    validates :attenuation_high, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
    validates :temp_low, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
    validates :temp_high, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
    validates_inclusion_of :temp_units, in: :valid_temperature_units

    def self.find_or_create_by_id(id)
      where(_id: id).first || create(_id: id)
    end

  end
end
