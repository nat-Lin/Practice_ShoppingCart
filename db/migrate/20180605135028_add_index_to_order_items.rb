class AddIndexToOrderItems < ActiveRecord::Migration[5.2]
  def change
    add_index :order_items, :order_id, name: "index_order_items_on_order_id"
  end
end
