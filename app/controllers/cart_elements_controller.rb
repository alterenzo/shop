class CartElementsController < ApplicationController

  def create
    @cart = current_cart
    cart_el = @cart.cart_elements.where(product_id: prod_id).first_or_initialize
    if cart_el.increment(:quantity).valid?
      cart_el.save
      flash[:notice] = "Product added to cart"
    else
      flash[:errors] = cart_el.errors.full_messages.to_sentence
    end
    session[:cart_id] = @cart.id
    redirect_to root_path
  end

  def destroy
    @cart_element = CartElement.find(params[:id])
    @cart_element.destroy
    current_cart.applied_vouchers.each do |applied|
      applied.destroy unless applied.valid?
    end
    redirect_to root_path
  end

  private

  def prod_id
    product_params[:product_id]
  end

  def product_params
    params.permit(:product_id)
  end

end
