class CheckoutController < ApplicationController
  def success
    flash[:success] = "Payment was successful!"
    redirect_to products_path
  end

  def cancel
    flash[:error] = "Payment was canceled."
    redirect_to products_path
  end
end