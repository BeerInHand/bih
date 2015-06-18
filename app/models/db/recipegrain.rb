class Db::Recipegrain < ActiveRecord::Base
  belongs_to :user
  belongs_to :recipe

  self.primary_key = :rg_rgid

end
