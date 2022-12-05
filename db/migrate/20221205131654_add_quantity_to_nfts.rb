class AddQuantityToNfts < ActiveRecord::Migration[7.0]
  def change
    add_column :nfts, :purchase_quantity, :integer
  end
end
