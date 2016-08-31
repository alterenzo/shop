require 'rails_helper'

RSpec.describe Cart, type: :model do

  let(:cart_element) { double "CartElement", price: 2.00 }
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
end
