class CreateBsCheckoutAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :bs_checkout_addresses do |t|
      t.string     :first_name
      t.string     :last_name
      t.string     :address
      t.string     :city
      t.integer    :zip
      t.references :country
      t.string     :phone
      t.references :addressable, polymorphic: true, index: { name: 'addressable_type' }
      t.string     :type
      t.boolean    :use_billing_address, default: false
      t.timestamps null: false
    end
  end
end
