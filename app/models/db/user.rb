class Db::User < ActiveRecord::Base
  has_many :recipes, :foreign_key => "re_usid"
  attr_reader :gonUser
  attr_reader :fullname
  attr_reader :forum

  self.primary_key = :us_usid

  def gonUser
    {
      "avatar"=>"zombatar.jpg", "id"=>self.id, "user"=>self.user, "pwd"=>self.pwd, "updated_at"=>self.updated_at,
      "postal"=>self.postal, "last"=>self.last, "gravatar"=>Digest::MD5.hexdigest(self.email), "email"=>self.email,
      "created_at"=>self.created_at, "first"=>self.first, "validated"=>self.validated,
      "forum"=>self.forum
    }
  end

  def fullname
    "#{self.first} #{self.last}".strip
  end

  def forum
    {
      "avatar"=>"zombatar.jpg", "postcount"=>0, "signature"=>"", "id"=>self.id, "username"=>self.user,
      "created_at"=>self.created_at, "confirmed"=>0, "groups"=>"", "password"=>"", "groupids"=>"", "emailaddress"=>self.email
    }
  end

end
