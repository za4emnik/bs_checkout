# This migration comes from bs_checkout (originally 20171114162714)
class RenameCartsToCreditCards < ActiveRecord::Migration[5.0]
  def change
    rename_table :bs_checkout_carts, :bs_checkout_credit_cards
  end
end