module Beerinhand
  class Recipe::Event
    include Mongoid::Document

    field :event_at,     type: DateTime
    field :type,         type: String
    field :gravity,      type: Float
    field :temperature,  type: Float
    field :note,         type: String

    embedded_in :recipe, inverse_of: :events

  end
end
