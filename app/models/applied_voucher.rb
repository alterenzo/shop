class AppliedVoucher < ApplicationRecord
  belongs_to :voucher
  belongs_to :cart
  has_and_belongs_to_many :categories

  validates :cart, presence: true
  validates :cart_id, uniqueness: { scope: :voucher_id }
  validate :verify_min_amount
  validate :verify_product_categories

  private

  def verify_min_amount
    if voucher
      message = "You must spend at least £#{voucher.min_amount} to use this coupon"
      errors.add(:base, message) unless cart.total_price > voucher.min_amount
    end
  end

  def verify_product_categories
    if voucher && !voucher.categories.empty?
      message = "At least one item from #{categories_to_string} is needed"

      errors.add(:base, message) unless cart.cart_elements.any? do |element|
        voucher.categories.include? element.product.category
      end
    end
  end

  def categories_to_string
    if voucher.categories
      voucher.categories.reduce("") { |string, cat| string += "#{cat.name} " }
    end
  end
end
