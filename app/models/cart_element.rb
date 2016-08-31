class CartElement < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  def price
    self.product.price * self.quantity
  end
end
