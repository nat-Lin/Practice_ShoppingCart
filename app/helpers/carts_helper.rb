module CartsHelper
	def current_cart
		@_lucart1201 ||= Cart.from_hash(session[:lucart1201])
	end
end
