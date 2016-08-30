require 'rails_helper'

RSpec.describe CartElementsController, type: :controller do
  describe 'POST #create' do
    context 'when no cart is in session' do
      it 'creates a new Cart on the database' do
        prod = create(:product)
        session[:cart_id] = nil

        expect{ post :create, params: {product_id: prod.id} }.to change(Cart, :count).by(1)
      end

      it 'creates a new CartElement' do
        prod = create(:product)
        session[:cart_id] = nil

        expect{ post :create, params: {product_id: prod.id} }.to change(CartElement, :count).by(1)
      end

      it 'stores the cart id in the session' do
        prod = create(:product)
        session[:cart_id] = nil

        post :create, params: {product_id: prod.id}

        expect(session[:cart_id]).not_to be_nil
      end
    end

    context 'when a cart is already in session' do
      it 'does not create a new cart' do
        cart = create(:cart)
        prod = create(:product)
        session[:cart_id] = cart.id

        expect{ post :create, params: {product_id: prod.id} }.not_to change(Cart, :count)
      end

      it 'adds elements to the cart that is in session' do
        cart = create(:cart)
        prod = create(:product)
        session[:cart_id] = cart.id

        expect{ post :create, params: {product_id: prod.id} }.to change(cart.cart_elements, :count).by(1)
      end

      it 'the cart in the sessions does not change' do
        cart = create(:cart)
        prod = create(:product)
        session[:cart_id] = cart.id

        post :create, params: {product_id: prod.id}

        expect(session[:cart_id]).to eq cart.id
      end
    end
  end
end
