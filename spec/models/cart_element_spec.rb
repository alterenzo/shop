require 'rails_helper'

RSpec.describe CartElement, type: :model do

  let(:product) { spy "product" }
  subject(:cart_el) { CartElement.create }

  describe "#price" do
    it 'calls #price on product' do
      allow(cart_el).to receive(:product).and_return(product)
      expect(product).to receive(:price)
      cart_el.price
    end
  end
end
