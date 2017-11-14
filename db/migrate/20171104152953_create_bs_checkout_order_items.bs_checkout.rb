class CreateBsCheckoutOrderItems < ActiveRecord::Migration[5.0]
  def change
    create_table :bs_checkout_order_items do |t|
      t.references :order
      t.integer    :product_id
      t.integer    :quantity, default: 0
      t.timestamps null: false
    end
  end
end
