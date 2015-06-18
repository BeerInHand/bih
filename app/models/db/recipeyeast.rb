class Db::Recipeyeast < ActiveRecord::Base
  belongs_to :user
  belongs_to :recipe

  self.primary_key = :ry_ryid

end
