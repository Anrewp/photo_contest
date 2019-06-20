class User < ApplicationRecord
  has_many  :photos,   dependent: :destroy
  has_many  :likes,    dependent: :destroy
  has_many  :comments, dependent: :destroy
  validates :email,    presence: true
  validates :provider, presence: true
end