class CreatePortfolioNfts < ActiveRecord::Migration[7.0]
  def change
    create_table :portfolio_nfts do |t|
      t.references :portfolio, null: false, foreign_key: true
      t.references :nft, null: false, foreign_key: true

      t.timestamps
    end
  end
end
