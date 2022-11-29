class AddImageToCollections < ActiveRecord::Migration[7.0]
  def change
    add_column :collections, :image, :string
  end
end
