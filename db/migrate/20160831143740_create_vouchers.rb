class CreateVouchers < ActiveRecord::Migration[5.0]
  def change
    create_table :vouchers do |t|
      t.string :code
      t.decimal :discount_amount

      t.timestamps
    end
  end
end
