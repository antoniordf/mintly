class CreateNfts < ActiveRecord::Migration[7.0]
  def change
    create_table :nfts do |t|
      t.string :name
      t.date :purchase_date
      t.float :purchase_price
      t.references :collection, null: false, foreign_key: true

      t.timestamps
    end
  end
end
