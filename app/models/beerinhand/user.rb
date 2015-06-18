module Beerinhand
  class User
    include Mongoid::Document
    include Mongoid::Timestamps
    include Concerns::Units

    field :user,           type: String
    field :first,          type: String
    field :last,           type: String
    field :email,          type: String
    field :pwd,            type: String
    field :postal,         type: String

    embeds_one :defaults, class_name: 'Beerinhand::User::Defaults'
    has_many :recipes, class_name: 'Beerinhand::Recipe'

    validates :user, presence: true

    validates_associated :defaults

    def self.find_or_create_by_id(id)
      where(_id: id).first || create(_id: id)
    end

    private

  end
end
