class ProductsController < ApplicationController

  	def index
  		if params[:product] == nil
  			@products = Product.all
  		elsif params[:product][:category] == nil and params[:product][:name] == ''
			@products = Product.all
  		elsif params[:product][:category] != nil and params[:product][:name] == ''
  			@category = Category.find_by(name:params[:product][:category])
			@products = Product.where(category:@category.id)
		elsif params[:product][:name] != '' and params[:product][:category] == nil
			@name = params[:product][:name]
			@products = Product.where("lower(name) like ?", "%" + params[:product][:name].downcase + "%")
			@products += Product.where("lower(description) like ?", "%" + params[:product][:name].downcase + "%")
		end
		@top_product = Product.all.sample
  		@hot_products = (Product.all - [@top_product]).sample(2)
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
