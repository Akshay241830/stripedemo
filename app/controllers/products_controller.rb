class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to products_path, notice: 'Product created successfully.'
    else
      render :new
    end
  end

  def checkout
    @product = Product.find(params[:id])

    session = Stripe::Checkout::Session.create({
      payment_method_types: ['card'],
      line_items: [{
        price_data: {
          currency: 'usd',
          product_data: {
            name: @product.name,
          },
          unit_amount: @product.price,
        },
        quantity: 1,
      }],
      mode: 'payment',
      success_url: checkout_success_url,
      cancel_url: checkout_cancel_url,
    })

    redirect_to session.url, allow_other_host: true
  end

  private

  def product_params
    params.require(:product).permit(:name, :price)
  end
end
