class CreateJoinTableVoucherCategory < ActiveRecord::Migration[5.0]
  def change
    create_join_table :vouchers, :categories do |t|
      # t.index [:voucher_id, :category_id]
      # t.index [:category_id, :voucher_id]
    end
  end
end
