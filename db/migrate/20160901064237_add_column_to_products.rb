class AddColumnToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :discount_amount, :decimal, default: 0.0
  end
end
