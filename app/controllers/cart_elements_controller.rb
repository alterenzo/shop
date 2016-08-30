class CartElementsController < ApplicationController

  def create
    @cart = current_cart
    CartElement.create(product_id: product_params[:product_id],
                       cart_id: @cart.id,
                       quantity: 1)
    session[:cart_id] = @cart.id
    redirect_to root_path
  end

  private

  def product_params
    params.permit(:product_id)
  end

end
