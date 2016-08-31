class CartsController < ApplicationController

  def update
    voucher = Voucher.where(code: code).first
    applied = AppliedVoucher.new(cart: current_cart,
                                 voucher: voucher)

    if applied.save
      flash[:notice] = "Coupon Applied!"
    else
      flash[:notice] = "Coupon not applied"
    end
    redirect_to root_path
  end

  private

  def code
    voucher_params[:voucher_code]
  end

  def voucher_params
    params.permit(:voucher_code)
  end
end
