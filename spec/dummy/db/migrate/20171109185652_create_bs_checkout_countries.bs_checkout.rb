# This migration comes from bs_checkout (originally 20171105152342)
class CreateBsCheckoutCountries < ActiveRecord::Migration[5.0]
  def change
    create_table :bs_checkout_countries do |t|
      t.string :name
      t.timestamps null: false
    end
  end
end
