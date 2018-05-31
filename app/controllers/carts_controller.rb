class CartsController < ApplicationController
	def add
		product = Product.find_by(id: params[:id])

		if  product.present?
			current_cart.add_item(product.id)
			session[:lucart1201] = current_cart.serialize
			redirect_to products_path, notice: "已放到購物車"
		else
			redirect_to products_path, notice: "查無此商品"
		end
	end

	def destroy
		session[:lucart1201] = nil
		redirect_to products_path, notice: "已清空購物車"
	end

	def checkout
	end
	
end
