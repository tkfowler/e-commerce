class OrdersController < ApplicationController
  def create
  	@cart_items = ProductCart.where(user:current_user)
	number = (0..10).map { (rand(1...10)) }.join
	@cart_items.each do |item|
		ProductOrder.create(product:item.product, user:current_user, quantity:item.quantity)
	end
	@order = ProductOrder.last.id
  	redirect_to "/users/#{current_user.id}"
  end
end
