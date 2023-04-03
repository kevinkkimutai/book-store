class Order < ApplicationRecord
  belongs_to :user
  belongs_to :book

  def total_price
    quantity * book.price
  end
end
