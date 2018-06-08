class OrdersController < ApplicationController
  def create
    # 建立訂單
    user = User.new(user_params)
    order = user.build_order(state: "panding")
    # 購物車轉清單
    current_cart.items.each do |item|
      order.order_items.build(product: item.product, quantity: item.quantity)
    end

    # 刷卡
    if user.save
      result = gateway.transaction.sale(
        :amount => current_cart.total_price,
        :payment_method_nonce => params[:payment_method_nonce])
      if result
        session[:lucart1201] = nil
        redirect_to products_path, notice: "感謝罐罐"
      else
        redirect_to products_path, notice: "刷卡失敗"
      end
    else
      redirect_to products_path, notice: "訂單產生失敗！！！"
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :tel, :address)
    end
end
