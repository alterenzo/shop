class Product < ApplicationRecord
  belongs_to :category

  def price
    self[:price] - discount_amount
  end

  def original_price
    self[:price]
  end

  def is_discounted?
    self[:price] > price
  end
end
