class User < ApplicationRecord
  has_many :articles
  validates :name, presence: true
  validates :email, presence: true

  has_secure_password
  validates :password, presence: true
end
