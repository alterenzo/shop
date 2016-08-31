class AddVoucherToAppliedVoucher < ActiveRecord::Migration[5.0]
  def change
    add_reference :applied_vouchers, :voucher, foreign_key: true, index: true
  end
end
