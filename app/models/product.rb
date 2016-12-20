class Product < ActiveRecord::Base
	#include Elasticsearch::Model
	# settings index: { number_of_shards: 1 }
	belongs_to :category
	has_many :product_orders
	has_many :users, through: :product_orders
	has_many :my_carts
	has_many :user_carts, through: :my_carts, source: :user
	has_attached_file :avatar
	validates_attachment_content_type :avatar, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
	# def as_indexed_json
	# 	self.as_json({
	# 		only: [:name, :description, :price, :category]
	# 	})
	# end
end

