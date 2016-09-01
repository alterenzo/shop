require 'rails_helper'

describe Product do
  describe '#price' do
    it 'returns the price after removing a discount amount' do
      prod = create(:product, price: 10.00, discount_amount: 5.0)

      result = prod.price

      expect(result).to eq 5.0
    end
  end

  describe '#original_price' do
    it 'returns the price before discounts' do
      prod = create(:product, price: 10.00, discount_amount: 5.0)

      result = prod.original_price

      expect(result).to eq 10.0
    end
  end

  describe '#is_discounted' do
    it 'is true if the product has a discount' do
      prod = create(:product, price: 10.00, discount_amount: 5.0)

      result = prod.is_discounted?

      expect(result).to be true
    end

    it 'is false if the product is not discounted' do
      prod = create(:product, price: 10.00, discount_amount: 0.0)

      result = prod.is_discounted?

      expect(result).to be false
    end
  end
end
