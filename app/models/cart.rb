class Cart
attr_reader :items

  def initialize(items = [])
    # 給予預設值 如果後面沒有傳入任何參數就給預設值 有給東西就塞東西
    @items = items
  end

  def activity(name)
    #name == "spend1000get100"
  end

  def add_item(id)
    found_item = items.find { |item| item.product_id == id }

    if found_item
      found_item.increment
    else
      items << CartItem.new(id)
    end
  end

  def empty?
    items.empty?
  end

  def total_price
    total = items.reduce(0) { |sum, item| sum + item.total_price}
    if xmas?
      total = total * 0.9
    elsif activity("spend1000get100")
      total = total - (total/1000) * 100
    end
    total
  end

  def serialize
      all_items = items.map do |p|
          { "product_id" => p.product_id,
            "quantity" => p.quantity
          }
        end

      { "items" => all_items }
  end

  def self.from_hash(hash)
    if hash.nil?
      new
      # 在類別方法裡面可以直接呼叫類別方法 不用宣告類別
    else
      all_items = hash["items"].map do |product|
        CartItem.new(product["product_id"], product["quantity"])
      end
      
      new all_items
    end
  end

  private
  def xmas?
    Time.now.month == 12 && Time.now.day == 25
  end
end
