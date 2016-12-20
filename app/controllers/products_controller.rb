class ProductsController < ApplicationController
  
  	def index
  		@products = Product.all
  	end

	def create
		@category = Category.find_by(name:params[:product][:category])
		@product = Product.create(product_params)
		@product.update(category:@category)
		redirect_to "/products"
	end
	def show
		@product = Product.find(params[:id])
	end

	private
	def product_params
		params.require(:product).permit(:name, :description, :price, :avatar)
	end
end
