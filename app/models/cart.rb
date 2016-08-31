class Cart < ApplicationRecord
  has_many :cart_elements
  has_many :applied_vouchers
  has_many :vouchers, through: :applied_vouchers

  def total_price
    cart_elements.empty? ? 0 : sum_of_cart_elements_prices
  end

  def total_voucher_amount
    vouchers.empty? ? 0 : sum_of_vouchers_amounts
  end

  def final_price
    total_price - total_voucher_amount
  end

  private

  def sum_of_cart_elements_prices
    cart_elements.reduce(0) { |sum, element| sum += element.price  }
  end

  def sum_of_vouchers_amounts
    vouchers.reduce(0) { |sum, element| sum += element.discount_amount  }
  end
end
