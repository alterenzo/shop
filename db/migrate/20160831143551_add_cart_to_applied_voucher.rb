class AddCartToAppliedVoucher < ActiveRecord::Migration[5.0]
  def change
    add_reference :applied_vouchers, :cart, foreign_key: true, index: true
  end
end
