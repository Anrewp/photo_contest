class User < ApplicationRecord
  has_many  :photos, dependent: :destroy
  has_many  :likes,  dependent: :destroy
  has_many  :comments,  dependent: :destroy
end