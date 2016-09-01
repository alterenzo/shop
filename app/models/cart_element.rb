class CartElement < ApplicationRecord
  belongs_to :cart
  belongs_to :product
  validate :available_in_stock

  def price
    self.product.price * self.quantity
  end

  private

  def available_in_stock
    errors.add(:base, "Not enough items available in stock") unless product.stock >= quantity
  end
end
