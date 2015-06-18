class Db::Recipehop < ActiveRecord::Base
  belongs_to :user
  belongs_to :recipe

  self.primary_key = :rh_rhid

end
