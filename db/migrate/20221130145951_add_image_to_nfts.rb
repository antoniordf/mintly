class AddImageToNfts < ActiveRecord::Migration[7.0]
  def change
    add_column :nfts, :image, :string
  end
end
