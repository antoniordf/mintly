class AddContractIdToCollections < ActiveRecord::Migration[7.0]
  def change
    add_column :collections, :contract_id, :string
  end
end
