class CartsController < ApplicationController
  def index
  	@cart = MyCart.find_by(user:current_user)
  end

  def create
  	@product = Product.find(params[:product_id])
  	binding.pry
  	MyCart.create(user:current_user, product:@product)
  	redirect_to "/products/#{@product.id}"
  end
end
