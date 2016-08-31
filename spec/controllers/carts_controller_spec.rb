require 'rails_helper'

RSpec.describe CartsController, type: :controller do
  describe 'PUT update' do
    context 'the voucher exists' do
      it 'applies a voucher to the cart' do
        cart = create(:cart)
        prod = create(:product)
        voucher = create(:voucher)
        session[:cart_id] = cart.id

        expect{ patch :update, params: { voucher_code: "VOUCHER" } }
          .to change(AppliedVoucher, :count).by(1)
      end
    end

    context 'voucher not found' do
      it 'doen\'t apply any voucher' do
        cart = create(:cart)
        prod = create(:product)
        session[:cart_id] = cart.id

        expect{ patch :update, params: { voucher_code: "VOUCHER" } }
          .not_to change(AppliedVoucher, :count)
      end
    end
  end
end
