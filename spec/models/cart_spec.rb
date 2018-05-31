require 'rails_helper'

RSpec.describe Cart, type: :model do
  let(:cart) { Cart.new }

  context "基本功能" do
    it "可以把商品丟到到購物車裡，然後購物車裡就有東西了" do
      cart.add_item(1)
      #expect(cart.empty?).to be false
      expect(cart).not_to be_empty
    end 

    it "加相同種類的商品，CartItem 不會增加，但商品的數量會改變" do
      3.times { cart.add_item(1)}
      5.times { cart.add_item(2)}
      expect(cart.items.count).to be 2
    end

    it "商品可以放到購物車裡，也可以再拿出來。" do
      p1 = Product.create(name: "香蕉", price: 100)
      cart.add_item(p1.id)
      expect(cart.items.first.product).to be_a Product
      expect(cart.items.first.product.name).to eq "香蕉"
    end

    it "可以計算整台購物車的總消費金額。" do
      p1 = Product.create(name: "香蕉", price: 100)
      p2 = Product.create(name: "芭樂", price: 100) 

      3.times { cart.add_item(p1.id)}
      5.times { cart.add_item(p2.id)} 

      expect(cart.total_price).to be 800
    end

    it "聖誕節的時候全面打九折。" do
      p1 = Product.create(name: "香蕉", price: 100)
      p2 = Product.create(name: "芭樂", price: 100) 

      3.times { cart.add_item(p1.id)}
      5.times { cart.add_item(p2.id)} 

      t = Time.local(2108, 12, 25, 12, 0, 0)
      Timecop.travel(t){
        expect(cart.total_price).to be (800 * 0.9)
      }
    end

    it "滿千送百" do
      p1 = Product.create(name: "香蕉", price: 100)
      p2 = Product.create(name: "芭樂", price: 100) 

      10.times { cart.add_item(p1.id)}
      5.times { cart.add_item(p2.id)} 

      if cart.activity("spend1000get100")
        expect(cart.total_price).to be (1500 - 100)
      end
    end
  end
  
  context "進階功能" do 
    it "把購物車變成 Hash " do
      3.times { cart.add_item(2) }
      5.times { cart.add_item(3) }

      expect(cart.serialize).to eq session_hash
    end

    it "把 Hash 變購物車" do
      cart = Cart.from_hash(session_hash)

      expect(cart.items.count).to be 2
      expect(cart.items.first.product_id).to be 2
      expect(cart.items.first.quantity).to be 3
    end
  end

  private
  def session_hash
    {
      "items" => [
        { "product_id" => 2, "quantity" => 3 },
        { "product_id" => 3, "quantity" => 5 }
      ]
    }
  end
end
