class Cart < ApplicationRecord
  has_many :cart_elements
  has_many :applied_vouchers
  has_many :vouchers, through: :applied_vouchers

  def total_price
    cart_elements.empty? ? 0 : sum_of_cart_elements_prices
  end


  private



  def sum_of_cart_elements_prices
    cart_elements.reduce(0) { |sum, element| sum += element.price  }
  end
end
