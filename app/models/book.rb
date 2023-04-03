class Book < ApplicationRecord
  belongs_to :user
  belongs_to :category
  
  validates :title, presence: true
  validates :price, presence: true
  has_many :orders, dependent: :destroy
end
