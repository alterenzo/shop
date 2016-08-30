class AddCartToCartElement < ActiveRecord::Migration[5.0]
  def change
    add_reference :cart_elements, :cart, foreign_key: true
  end
end
