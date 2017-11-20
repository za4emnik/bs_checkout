class CreateBsCheckoutCoupons < ActiveRecord::Migration[5.0]
  def change
    create_table :bs_checkout_coupons do |t|
      t.string     :code
      t.decimal    :value, precision: 8, scale: 2
      t.references :order
      t.boolean    :active, default: true
      t.timestamps null: false
    end
  end
end
