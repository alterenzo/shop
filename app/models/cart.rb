class Cart < ApplicationRecord
  has_many :cart_elements

  def total_price
    return 0 if cart_elements.empty?
    cart_elements.reduce(0) { |sum, element| sum += element.price  }
  end
end
