class AddMinAmountToVoucher < ActiveRecord::Migration[5.0]
  def change
    add_column :vouchers, :min_amount, :decimal, default: 0
  end
end
