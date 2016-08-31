class CartElementsController < ApplicationController

  def create
    @cart = current_cart
    cart_el = @cart.cart_elements.where(product_id: product_params[:product_id]).first_or_create
    cart_el.increment(:quantity).save
    session[:cart_id] = @cart.id
    redirect_to root_path
  end

  def destroy
    @cart_element = CartElement.find(params[:format])
    @cart_element.destroy
    redirect_to root_path
  end

  private

  def product_params
    params.permit(:product_id)
  end

end
