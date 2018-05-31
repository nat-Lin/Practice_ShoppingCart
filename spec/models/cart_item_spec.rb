
require 'rails_helper'

RSpec.describe CartItem, type: :model do
  it "每個 Cart Item 都可以計算它自己的金額（小計）。" do
    cart = Cart.new
    p1 = Product.create(name: "香蕉", price: 100)
    p2 = Product.create(name: "芭樂", price: 100)

    3.times { cart.add_item(p1.id)}
    5.times { cart.add_item(p2.id)}

    expect(cart.items.first.total_price).to be 300
    expect(cart.items.last.total_price).to be 500
  end
end
