class User < ActiveRecord::Base
  has_secure_password
  has_many :seeds
  has_many :posts

end
