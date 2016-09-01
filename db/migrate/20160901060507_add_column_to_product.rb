class AddColumnToProduct < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :stock, :integer, default: 1
  end
end
