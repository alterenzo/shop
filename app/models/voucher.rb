class Voucher < ApplicationRecord
  has_many :applied_vouchers
  has_many :carts, through: :applied_vouchers
end
