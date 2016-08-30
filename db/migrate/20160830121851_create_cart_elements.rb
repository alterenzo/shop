class CreateCartElements < ActiveRecord::Migration[5.0]
  def change
    create_table :cart_elements do |t|
      t.integer :quantity

      t.timestamps
    end
  end
end
