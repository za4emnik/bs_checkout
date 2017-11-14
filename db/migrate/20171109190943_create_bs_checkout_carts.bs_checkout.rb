class CreateBsCheckoutCarts < ActiveRecord::Migration[5.0]
  def change
    create_table :bs_checkout_carts do |t|
      t.string     :number
      t.string     :name
      t.string     :date
      t.integer    :cvv
      t.references :order
      t.timestamps null: false
    end
  end
end
