class Db::Recipemisc < ActiveRecord::Base
  belongs_to :user
  belongs_to :recipe

  self.primary_key = :rm_rmid

end
