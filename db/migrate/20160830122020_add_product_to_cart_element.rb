class AddProductToCartElement < ActiveRecord::Migration[5.0]
  def change
    add_reference :cart_elements, :product, foreign_key: true
  end
end
