class User < ActiveRecord::Base
  has_secure_password
  has_many :seeds
  validates :name, presence: true
  validates :email, presence: true
  validates :password, presence: true, length: {minimum: 8}
end
