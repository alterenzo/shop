class AppliedVoucher < ApplicationRecord
  belongs_to :voucher
  belongs_to :cart
  # validates :verify_voucher
  #
  # def verify_voucher
  #   cart.total_price > voucher.
  # end

end
