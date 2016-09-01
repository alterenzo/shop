require 'rails_helper'

RSpec.describe Cart, type: :model do

  let(:cart_element) { double "CartElement", price: 2.00 }
  let(:voucher) { double "Voucher", discount_amount: 1.00 }
  subject(:cart) { Cart.create }

  describe "#total_price" do
    it 'returns the sum of the prices of all elements' do
      allow(cart).to receive(:cart_elements).and_return([cart_element, cart_element])

      result = cart.total_price

      expect(result).to eq 4.00
    end

    it 'returns 0 if no items in the cart' do
      allow(cart).to receive(:cart_elements).and_return([])

      result = cart.total_price

      expect(result).to eq 0
    end
  end

  describe '#total_voucher_amount' do
    it 'returns the total discount amount' do
      allow(cart).to receive(:vouchers).and_return([voucher])

      result = cart.total_voucher_amount

      expect(result).to eq 1.00
    end

    it 'returns 0 if no discounts applied to cart' do
      allow(cart).to receive(:vouchers).and_return([])

      result = cart.total_voucher_amount

      expect(result).to eq 0
    end
  end

  describe '#final_price' do
    it 'returns 0 if the final price is less than 0' do
      allow(cart).to receive(:cart_elements).and_return([cart_element])
      allow(cart).to receive(:vouchers).and_return([voucher, voucher, voucher])

      result = cart.final_price

      expect(result).to eq 0
    end
  end
end
