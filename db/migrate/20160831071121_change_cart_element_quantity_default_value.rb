class ChangeCartElementQuantityDefaultValue < ActiveRecord::Migration[5.0]
  def change
    change_column :cart_elements, :quantity, :integer, default: 0
  end
end
