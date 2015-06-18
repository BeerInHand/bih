class Db::Recipedate < ActiveRecord::Base
  belongs_to :user
  belongs_to :recipe

  self.primary_key = :rd_rdid

end
