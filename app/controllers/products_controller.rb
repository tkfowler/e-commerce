class ProductsController < ApplicationController
  	Product.__elasticsearch__.import

  	def index
  		if params[:product] == nil
  			@products = Product.all
  		elsif params[:product][:category] == nil and params[:product][:name] == ''
			@products = Product.all
  		elsif params[:product][:category] != nil and params[:product][:name] == ''
  			@category = Category.find_by(name:params[:product][:category])
			@products = Product.__elasticsearch__.search(@category.id).records
		elsif params[:product][:name] != '' and params[:product][:category] == nil
			@products = Product.__elasticsearch__.search(params[:product][:name]).records
		end
  		@top_product = Product.last
  		@hot_products = Product.limit(2)
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
