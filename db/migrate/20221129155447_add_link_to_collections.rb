class AddLinkToCollections < ActiveRecord::Migration[7.0]
  def change
    add_column :collections, :link, :string
  end
end
